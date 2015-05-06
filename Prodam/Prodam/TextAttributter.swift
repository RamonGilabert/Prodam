import Cocoa

class TextAttributter: NSObject {

    class func attributedStringForButtons(stringValue: String) -> NSAttributedString {
        let mutableString = NSMutableAttributedString(string: stringValue)
        mutableString.addAttribute(NSForegroundColorAttributeName, value: NSColor.whiteColor(), range: NSMakeRange(0, mutableString.length))
        mutableString.addAttribute(NSFontAttributeName, value: NSFont(name: "AvenirNext-DemiBold", size: 20)!, range: NSMakeRange(0, mutableString.length))

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.CenterTextAlignment
        mutableString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, mutableString.length))

        return mutableString
    }
}
