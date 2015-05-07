import Cocoa

class TextAttributter: NSObject {

    class func attributedStringForButtons(stringValue: String, font: String, color: NSColor) -> NSAttributedString {
        let mutableString = NSMutableAttributedString(string: stringValue)
        mutableString.addAttribute(NSForegroundColorAttributeName, value: color, range: NSMakeRange(0, mutableString.length))
        mutableString.addAttribute(NSFontAttributeName, value: NSFont(name: font, size: 20)!, range: NSMakeRange(0, mutableString.length))

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.CenterTextAlignment
        mutableString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, mutableString.length))

        return mutableString
    }
}
