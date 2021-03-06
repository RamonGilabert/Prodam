import Cocoa

class TextSplitter: NSObject {
    
    class func checkNewStringForTextField(stringValue: String, fontSize: CGFloat) -> NSAttributedString {
        let arrayOfWords = split(stringValue, maxSplit: 1, allowEmptySlices: true, isSeparator: {$0 == " "})
        let firstString = arrayOfWords[0]
        let finalMutableString = NSMutableAttributedString()
        var secondString = ""
        var mutableStringFirstPart = NSMutableAttributedString()
        var mutableStringSecondPart = NSMutableAttributedString()

        if arrayOfWords.count > 1 {
            secondString = arrayOfWords[1]

            mutableStringFirstPart = handleFirstPartOfSentence(firstString + " ", fontSize: fontSize)

            mutableStringSecondPart = NSMutableAttributedString(string: secondString)
            mutableStringSecondPart.addAttribute(NSFontAttributeName, value: NSFont(name: "HelveticaNeue-Medium", size: fontSize)!, range: NSMakeRange(0, secondString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)))
            mutableStringSecondPart.addAttribute(NSForegroundColorAttributeName, value: NSColor(calibratedHue:0, saturation:0, brightness:0.2, alpha:1), range: NSMakeRange(0, secondString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)))
        } else {
            mutableStringFirstPart = handleFirstPartOfSentence(firstString, fontSize: fontSize)
        }

        finalMutableString.appendAttributedString(mutableStringFirstPart)
        finalMutableString.appendAttributedString(mutableStringSecondPart)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.CenterTextAlignment
        finalMutableString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, finalMutableString.length))
        
        return finalMutableString
    }

    // MARK: Helper methods

    class func handleFirstPartOfSentence(firstString: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let mutableString = NSMutableAttributedString(string: firstString)
        mutableString.addAttribute(NSFontAttributeName, value: NSFont(name: "HelveticaNeue-Light", size: fontSize)!, range: NSMakeRange(0, firstString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)))
        mutableString.addAttribute(NSForegroundColorAttributeName, value: NSColor(calibratedHue:0, saturation:0, brightness:0.2, alpha:1), range: NSMakeRange(0, firstString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)))

        return mutableString
    }
}
