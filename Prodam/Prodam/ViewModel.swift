import Cocoa

struct Constant {
    struct Window {
        static let Width = 300 as CGFloat
        static let Height = 200 as CGFloat
    }

    struct WindowLayout {
        static let MinimumPaddingButton = 6 as CGFloat
        static let HeightOfButton = Constant.Window.Height / 3.5
        static let WidthDonePauseButtons = Constant.Window.Width/2 - (1.5 * Constant.WindowLayout.MinimumPaddingButton)
        static let WidthMainButton = Constant.Window.Width - (2 * Constant.WindowLayout.MinimumPaddingButton)
        static let HalfScreenPadding = Constant.WindowLayout.MinimumPaddingButton/2 + Constant.Window.Width/2
    }
}

class ViewModel: NSObject {

    // MARK: Main View Controller: Layout

    func layoutFunctionalButtonsMainView(viewController: NSViewController) -> NSButton {
        let button = addButtonMainView(Constant.WindowLayout.MinimumPaddingButton, width: Constant.WindowLayout.WidthMainButton, alpha: 1.0, text: "start", viewController: viewController)
        button.attributedTitle = attributedStringForButtons("START WORKING")

        return button
    }

    func layoutDoneButtonMainView(viewController: NSViewController) -> NSButton {
        let button = addButtonMainView(Constant.WindowLayout.MinimumPaddingButton, width: Constant.WindowLayout.WidthDonePauseButtons, alpha: 0.0, text: "stop", viewController: viewController)

        return button
    }

    func layoutPauseButtonMainView(viewController: NSViewController) -> NSButton {
        let button = addButtonMainView(Constant.WindowLayout.HalfScreenPadding, width: Constant.WindowLayout.WidthDonePauseButtons, alpha: 0.0, text: "pause", viewController: viewController)

        return button
    }

    func layoutTaskTextFieldMainView(fieldDelegate: NSTextFieldDelegate, viewController: NSViewController) -> NSTextField {
        let textField = NSTextField(frame: NSMakeRect(50, Constant.Window.Height - 32, Constant.Window.Width - 100, 24))
        textField.bezeled = false
        textField.bordered = false
        textField.backgroundColor = NSColor.clearColor()
        textField.textColor = NSColor(calibratedHue:0, saturation:0, brightness:0.2, alpha:1)
        textField.alignment = NSTextAlignment.CenterTextAlignment
        textField.placeholderString = "Enter your new task..."
        textField.font = NSFont(name: "HelveticaNeue-Light", size: 18)
        textField.focusRingType = NSFocusRingType.None
        textField.allowsEditingTextAttributes = true
        textField.delegate = fieldDelegate

        viewController.view.addSubview(textField)

        return textField
    }

    func layoutTimerTextFieldMainView(viewController: NSViewController) -> NSTextField {
        let textField = NSTextField(frame: NSMakeRect(40, Constant.Window.Height/4 + 30, Constant.Window.Width - 80, 0))
        textField.bezeled = false
        textField.bordered = false
        textField.editable = false
        textField.selectable = false
        textField.backgroundColor = NSColor.clearColor()
        textField.textColor = NSColor(calibratedHue:0, saturation:0, brightness:0.2, alpha:1)
        textField.alignment = NSTextAlignment.CenterTextAlignment
        textField.stringValue = "15:00"
        textField.font = NSFont(name: "AvenirNextCondensed-DemiBold", size: 85)
        textField.sizeToFit()
        textField.frame = NSMakeRect((Constant.Window.Width - textField.frame.width)/2, (Constant.Window.Height - textField.frame.height)/2 + 25, textField.frame.width, textField.frame.height)
        textField.alphaValue = 0.0

        viewController.view.addSubview(textField)

        return textField
    }

    func layoutEditableTextFieldMainView(viewController: NSViewController) -> NSTextField {
        let textField = NSTextField(frame: NSMakeRect(0, 0, 0, 0))
        textField.bezeled = false
        textField.bordered = false
        textField.backgroundColor = NSColor.clearColor()
        textField.textColor = NSColor(calibratedHue:0, saturation:0, brightness:0.2, alpha:1)
        textField.alignment = NSTextAlignment.RightTextAlignment
        textField.stringValue = "15"
        textField.font = NSFont(name: "HelveticaNeue-Bold", size: 70)
        textField.sizeToFit()
        textField.frame = NSMakeRect((Constant.Window.Width - textField.frame.width)/2 - 50, (Constant.Window.Height - textField.frame.height)/2 + 20, textField.frame.width + 50, textField.frame.height)
        textField.becomeFirstResponder()
        textField.focusRingType = NSFocusRingType.None
        
        viewController.view.addSubview(textField)

        return textField
    }

    func layoutMinutesTextFieldMainView(viewController: NSViewController, editableTextField: NSTextField) -> NSTextField {
        let textField = NSTextField(frame: NSMakeRect(0, 0, 0, 0))
        textField.bezeled = false
        textField.bordered = false
        textField.editable = false
        textField.selectable = false
        textField.backgroundColor = NSColor.clearColor()
        textField.textColor = NSColor(calibratedHue:0, saturation:0, brightness:0.2, alpha:1)
        textField.alignment = NSTextAlignment.CenterTextAlignment
        textField.stringValue = "min"
        textField.font = NSFont(name: "AvenirNext-DemiBold", size: 20)
        textField.sizeToFit()
        textField.frame = NSMakeRect(editableTextField.frame.origin.x + editableTextField.frame.width, editableTextField.frame.origin.y + 10, textField.frame.width, textField.frame.height)

        viewController.view.addSubview(textField)

        return textField
    }

    // MARK: Main View Controller: Helper methods

    func addButtonMainView(xPosition: CGFloat, width: CGFloat, alpha: CGFloat, text: NSString, viewController: NSViewController) -> NSButton {
        let button = NSButton()

        button.frame = NSMakeRect(xPosition, Constant.WindowLayout.MinimumPaddingButton/1.5, width, Constant.WindowLayout.HeightOfButton)
        button.image = NSImage(named: "background-\(text)-button")
        button.bordered = false
        button.setButtonType(NSButtonType.MomentaryChangeButton)
        button.attributedTitle = attributedStringForButtons(text.uppercaseString)
        button.alphaValue = alpha
        let selectorString = "on\(text.capitalizedString)ButtonPressed"
        button.action = NSSelectorFromString(selectorString)
        button.target = viewController

        viewController.view.addSubview(button)

        return button
    }

    func attributedStringForButtons(stringValue: String) -> NSAttributedString {
        let mutableString = NSMutableAttributedString(string: stringValue)
        mutableString.addAttribute(NSForegroundColorAttributeName, value: NSColor.whiteColor(), range: NSMakeRange(0, mutableString.length))
        mutableString.addAttribute(NSFontAttributeName, value: NSFont(name: "AvenirNext-DemiBold", size: 20)!, range: NSMakeRange(0, mutableString.length))

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.CenterTextAlignment
        mutableString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, mutableString.length))

        return mutableString
    }
}
