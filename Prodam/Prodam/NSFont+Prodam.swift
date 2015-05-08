import Cocoa

class NSFont_Prodam: NSFont {

    class func textFieldNormalField() -> NSFont {
        return NSFont(name: "HelveticaNeue-Light", size: 18)!
    }

    class func mainTimer() -> NSFont {
        return NSFont(name: "AvenirNextCondensed-DemiBold", size: 75)!
    }

    class func mainTimerEditable() -> NSFont {
        return NSFont(name: "HelveticaNeue-Bold", size: 70)!
    }

    class func mainMinutesTextField() -> NSFont {
        return NSFont(name: "AvenirNext-DemiBold", size: 20)!
    }

    class func breakHeaderTextField() -> NSFont {
        return NSFont(name: "OpenSans-Semibold", size: 50)!
    }

    class func breakTimerFont() -> NSFont {
        return NSFont(name: "OpenSans", size: 225)!
    }

    class func breakMinutesFont() -> NSFont {
        return NSFont(name: "OpenSans", size: 30)!
    }

    class func breakQuoteFont() -> NSFont {
        return NSFont(name: "OpenSans-Italic", size: 18)!
    }

    class func breakAuthorFont() -> NSFont {
        return NSFont(name: "OpenSansLight-Italic", size: 16)!
    }
}
