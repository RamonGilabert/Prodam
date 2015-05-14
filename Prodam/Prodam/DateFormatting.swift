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

    class func getTextWithoutBiggerThanMinutes(textField: NSTextField) -> String {
        let numberFormatter = NSNumberFormatter()

        if let numberMinutes = numberFormatter.numberFromString(textField.stringValue) {
            if numberMinutes.integerValue > 60 {
                textField.stringValue = "59:59"
            } else if numberMinutes.integerValue < 1 {
                let numberSeconds = Int(numberMinutes.floatValue * 60)

                if numberSeconds < 10 {
                    return "00:0\(numberSeconds)"
                } else {
                    return "00:\(numberSeconds)"
                }
            } else {
                if numberMinutes.integerValue < 10 {
                    return "0\(numberMinutes.integerValue):00"
                } else {
                    return "\(numberMinutes.integerValue):00"
                }
            }
        }

        return textField.stringValue
    }

    class func getStringFormattedWithDate(textField: NSTextField) -> String {
        let dateFormatter = NSDateFormatter()

        if textField.stringValue.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 6 {
            dateFormatter.dateFormat = "hh:mm:ss"
        } else {
            dateFormatter.dateFormat = "mm:ss"
        }

        let dateInTextField = dateFormatter.dateFromString(textField.stringValue)
        let realDateNow = dateInTextField!.dateByAddingTimeInterval(-1)
        
        return dateFormatter.stringFromDate(realDateNow)
    }

    class func getNumberFromDate(textField: NSTextField) -> Int {
        let dateFormatter = NSDateFormatter()
        var stringDate = ""

        if textField.stringValue.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 6 {
            dateFormatter.dateFormat = "hh:mm:ss"
            stringDate = "00:00:00"
        } else {
            dateFormatter.dateFormat = "mm:ss"
            stringDate = "00:00"
        }

        let actualDate = dateFormatter.dateFromString(textField.stringValue)
        let finalDate = dateFormatter.dateFromString(stringDate)
        let components = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.components(NSCalendarUnit.CalendarUnitSecond, fromDate: finalDate!, toDate: actualDate!, options: NSCalendarOptions.allZeros)

        return components.second
    }
}
