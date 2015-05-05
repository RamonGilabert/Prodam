import Cocoa

class TextSplitter: NSObject {
    
    class func checkNewStringForTextField(stringValue: String) -> NSAttributedString {
        let arrayOfWords = split(stringValue, maxSplit: 1, allowEmptySlices: true, isSeparator: {$0 == " "})
        let firstString = arrayOfWords[0]
        let finalMutableString = NSMutableAttributedString()
        var secondString = ""
        var concatenatedString = ""
        var mutableStringFirstPart = NSMutableAttributedString()
        var mutableStringSecondPart = NSMutableAttributedString()

        if arrayOfWords.count > 1 {
            secondString = arrayOfWords[1]
            concatenatedString = "\(firstString) \(secondString)"

            mutableStringFirstPart = NSMutableAttributedString(string: "\(firstString) ")
            mutableStringFirstPart.addAttribute(NSFontAttributeName, value: NSFont(name: "HelveticaNeue-Light", size: 18)!, range: NSMakeRange(0, firstString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) + 1))
            mutableStringFirstPart.addAttribute(NSForegroundColorAttributeName, value: NSColor(calibratedHue:0, saturation:0, brightness:0.2, alpha:1), range: NSMakeRange(0, firstString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) + 1))

            mutableStringSecondPart = NSMutableAttributedString(string: secondString)
            mutableStringSecondPart.addAttribute(NSFontAttributeName, value: NSFont(name: "HelveticaNeue-Medium", size: 18)!, range: NSMakeRange(0, secondString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)))
            mutableStringSecondPart.addAttribute(NSForegroundColorAttributeName, value: NSColor(calibratedHue:0, saturation:0, brightness:0.2, alpha:1), range: NSMakeRange(0, secondString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)))
        } else {
            concatenatedString = firstString

            mutableStringFirstPart = NSMutableAttributedString(string: firstString)
            mutableStringFirstPart.addAttribute(NSFontAttributeName, value: NSFont(name: "HelveticaNeue-Light", size: 18)!, range: NSMakeRange(0, firstString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)))
            mutableStringFirstPart.addAttribute(NSForegroundColorAttributeName, value: NSColor(calibratedHue:0, saturation:0, brightness:0.2, alpha:1), range: NSMakeRange(0, firstString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)))
        }

        finalMutableString.appendAttributedString(mutableStringFirstPart)
        finalMutableString.appendAttributedString(mutableStringSecondPart)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.CenterTextAlignment
        finalMutableString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, finalMutableString.length))
        
        return finalMutableString
    }
}
