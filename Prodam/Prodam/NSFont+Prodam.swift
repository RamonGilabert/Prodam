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
}
