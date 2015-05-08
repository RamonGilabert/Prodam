import Cocoa

class NSColor_Prodam: NSFont {

    class func almostBlackColor() -> NSColor {
        return NSColor(calibratedHue:0, saturation:0, brightness:0.22, alpha:1)
    }

    class func colorBreakLabels() -> NSColor {
        return NSColor.whiteColor()
    }
}
