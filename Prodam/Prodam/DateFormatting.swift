import Cocoa

class DateFormatting: NSObject {

    class func getTextFromNumberOfMinutes(textField: NSTextField) -> String {
        let numberInEditableString = NSNumberFormatter().numberFromString(textField.stringValue)?.floatValue

        if numberInEditableString > 60 {
            let numberOfHours = Int(numberInEditableString!/60)
            let numberOfMinutes = Int(numberInEditableString!) - (numberOfHours * 60)
            var stringOfHours = ""

            if numberOfHours < 10 {
                stringOfHours = "0\(numberOfHours)"
            } else {
                stringOfHours = "\(numberOfHours)"
            }

            if numberOfMinutes < 10 {
                return "\(stringOfHours):0\(Int(numberOfMinutes)):00"
            } else {
                return "\(stringOfHours):\(Int(numberOfMinutes)):00"
            }
        } else if numberInEditableString < 1 {
            let numberOfSeconds = numberInEditableString! * 60
            var stringOfSeconds = ""

            if numberOfSeconds < 10 {
                stringOfSeconds = "0\(Int(numberOfSeconds))"
            } else {
                stringOfSeconds = "\(Int(numberOfSeconds))"
            }

            return "00:\(stringOfSeconds)"
        } else {
            return "\(textField.stringValue):00"
        }
    }
}
