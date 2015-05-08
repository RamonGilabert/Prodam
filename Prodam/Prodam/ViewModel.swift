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
        button.attributedTitle = TextAttributter.attributedStringForButtons("START WORKING", font: "AvenirNext-DemiBold", color: NSColor.whiteColor())

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
        let textField = addBasicTextField(viewController, text: "")
        textField.frame = NSMakeRect(50, Constant.Window.Height - 32, Constant.Window.Width - 100, 24)
        textField.placeholderString = "Enter your new task..."
        textField.font = NSFont(name: "HelveticaNeue-Light", size: 18)
        textField.focusRingType = NSFocusRingType.None
        textField.allowsEditingTextAttributes = true
        textField.delegate = fieldDelegate

        viewController.view.addSubview(textField)

        return textField
    }

    func layoutTimerTextFieldMainView(viewController: NSViewController) -> NSTextField {
        let textField = addBasicTextField(viewController, text: "15:00")
        textField.editable = false
        textField.selectable = false
        textField.font = NSFont(name: "AvenirNextCondensed-DemiBold", size: 75)
        textField.sizeToFit()
        textField.frame = NSMakeRect((Constant.Window.Width - (textField.frame.width + 100))/2, (Constant.Window.Height - textField.frame.height)/2 + 25, textField.frame.width + 100, textField.frame.height)
        textField.alphaValue = 0.0

        return textField
    }

    func layoutEditableTextFieldMainView(viewController: NSViewController) -> NSTextField {
        let textField = addBasicTextField(viewController, text: "15")
        textField.alignment = NSTextAlignment.RightTextAlignment
        textField.font = NSFont(name: "HelveticaNeue-Bold", size: 70)
        textField.sizeToFit()
        textField.frame = NSMakeRect((Constant.Window.Width - textField.frame.width)/2 - 100, (Constant.Window.Height - textField.frame.height)/2 + 20, textField.frame.width + 100, textField.frame.height)
        textField.becomeFirstResponder()
        textField.focusRingType = NSFocusRingType.None

        return textField
    }

    func layoutMinutesTextFieldMainView(viewController: NSViewController, editableTextField: NSTextField) -> NSTextField {
        let textField = addBasicTextField(viewController, text: "min")
        textField.editable = false
        textField.selectable = false
        textField.font = NSFont(name: "AvenirNext-DemiBold", size: 20)
        textField.sizeToFit()
        textField.frame = NSMakeRect(editableTextField.frame.origin.x + editableTextField.frame.width, editableTextField.frame.origin.y + 10, textField.frame.width, textField.frame.height)

        return textField
    }

    func layoutButtonTasksMainView(viewController: NSViewController) -> NSButton {
        let button = NSButton(frame: NSMakeRect(14, Constant.Window.Height - 30, 20, 20))
        button.image = NSImage(named: "done-button")
        button.bordered = false
        button.target = viewController
        button.action = "onTasksButtonPressed"
        button.enabled = false

        viewController.view.addSubview(button)

        return button
    }

    func layoutButtonSettingsMainView(viewController: NSViewController) -> NSButton {
        let button = NSButton(frame: NSMakeRect(Constant.Window.Width - 34, Constant.Window.Height - 30, 20, 20))
        button.image = NSImage(named: "settings-button")
        button.bordered = false
        button.target = viewController
        button.action = "onSettingsButtonPressed"

        viewController.view.addSubview(button)

        return button
    }

    // MARK: Break view layout

    func breakLayoutHeaderLabel(viewController: NSViewController) -> NSTextField {
        let label = NSTextField()
        label.bordered = false
        label.bezeled = false
        label.editable = false
        label.selectable = false
        label.drawsBackground = false
        label.stringValue = "TAKING A BREAK"
        label.textColor = NSColor.whiteColor()
        label.alphaValue = 0.6
        label.font = NSFont(name: "OpenSans-Semibold", size: 40)
        label.sizeToFit()
        label.frame = NSMakeRect((viewController.view.frame.width - label.frame.width)/2, viewController.view.frame.height - label.frame.height - 25, label.frame.width, label.frame.height)

        viewController.view.addSubview(label)

        return label
    }

    func breakLayoutEditableLabel(viewController: NSViewController) -> NSTextField {
        let label = NSTextField()
        label.bordered = false
        label.bezeled = false
        label.drawsBackground = false
        label.stringValue = "5"
        label.textColor = NSColor.whiteColor()
        label.alphaValue = 0.6
        label.font = NSFont(name: "OpenSans", size: 225)
        label.focusRingType = NSFocusRingType.None
        label.alignment = NSTextAlignment.RightTextAlignment
        label.sizeToFit()
        label.frame = NSMakeRect((viewController.view.frame.width - label.frame.width*4.75)/2, (viewController.view.frame.height - label.frame.height)/2 + 75, label.frame.width * 3, label.frame.height)

        viewController.view.addSubview(label)

        return label
    }

    func breakLayoutMinutesLabel(viewController: NSViewController, sideLabel: NSTextField) -> NSTextField {
        let label = NSTextField()
        label.bordered = false
        label.bezeled = false
        label.editable = false
        label.selectable = false
        label.drawsBackground = false
        label.stringValue = "min"
        label.textColor = NSColor.whiteColor()
        label.alphaValue = 0.6
        label.font = NSFont(name: "OpenSans", size: 30)
        label.sizeToFit()
        label.frame = NSMakeRect(sideLabel.frame.origin.x + sideLabel.frame.width + 15, sideLabel.frame.origin.y + 55, label.frame.width, label.frame.height)

        viewController.view.addSubview(label)

        return label
    }

    func breakLayoutWorkAgainButton(viewController: NSViewController, sideLabel: NSTextField) -> NSButton {
        let button = NSButton(frame: NSMakeRect((viewController.view.frame.width / 2) - 290, sideLabel.frame.origin.y - 125, 265, 55))
        button.bordered = false
        button.image = NSImage(named: "background-break-button")
        button.attributedTitle = TextAttributter.attributedStringForButtons("WORK AGAIN", font: "AvenirNext-DemiBold", color: NSColor(calibratedHue:0, saturation:0, brightness:0.22, alpha:1))
        button.setButtonType(NSButtonType.MomentaryChangeButton)
        button.alphaValue = 0.8
        button.target = viewController
        button.action = "onWorkAgainButtonPressed"

        viewController.view.addSubview(button)

        return button
    }

    func breakLayoutStartBreakButton(viewController: NSViewController, sideLabel: NSTextField) -> NSButton {
        let button = NSButton(frame: NSMakeRect((viewController.view.frame.width / 2) + 25, sideLabel.frame.origin.y - 125, 265, 55))
        button.bordered = false
        button.image = NSImage(named: "background-break-button")
        button.attributedTitle = TextAttributter.attributedStringForButtons("START BREAK", font: "AvenirNext-DemiBold", color: NSColor(calibratedHue:0, saturation:0, brightness:0.22, alpha:1))
        button.setButtonType(NSButtonType.MomentaryChangeButton)
        button.alphaValue = 0.8
        button.target = viewController
        button.action = "onStartBreakButtonPressed"

        viewController.view.addSubview(button)

        return button
    }

    func breakLayoutCloseButton(viewController: NSViewController) -> NSButton {
        let button = NSButton(frame: NSMakeRect(17, viewController.view.frame.height - 34, 17, 17))
        button.bordered = false
        button.image = NSImage(named: "close-break-button")
        button.setButtonType(NSButtonType.MomentaryChangeButton)
        button.alphaValue = 0.8
        button.target = viewController
        button.action = "onCloseButtonPressed"

        viewController.view.addSubview(button)

        return button
    }

    func breakLayoutQuote(viewController: NSViewController, topButton: NSButton) -> NSTextField {
        let label = NSTextField()
        label.bordered = false
        label.bezeled = false
        label.editable = false
        label.selectable = false
        label.drawsBackground = false
        label.stringValue = "Stay hungry, stay foolish..."
        label.textColor = NSColor.whiteColor()
        label.alphaValue = 0.6
        label.font = NSFont(name: "OpenSansLight-Italic", size: 18)
        label.sizeToFit()
        label.frame = NSMakeRect((viewController.view.frame.width - label.frame.width)/2, (topButton.frame.origin.y - label.frame.height)/2 + label.frame.height/2, label.frame.width, label.frame.height)

        viewController.view.addSubview(label)

        return label
    }

    func breakLayoutAuthorQuote(viewController: NSViewController, authorLabel: NSTextField) -> NSTextField {
        let label = NSTextField()
        label.bordered = false
        label.bezeled = false
        label.editable = false
        label.selectable = false
        label.drawsBackground = false
        label.stringValue = "Steve Jobs"
        label.textColor = NSColor.whiteColor()
        label.alphaValue = 0.6
        label.font = NSFont(name: "OpenSansLight-Italic", size: 16)
        label.sizeToFit()
        label.frame = NSMakeRect(authorLabel.frame.origin.x + authorLabel.frame.width - label.frame.width, authorLabel.frame.origin.y - label.frame.height, label.frame.width, label.frame.height)

        viewController.view.addSubview(label)

        return label
    }

    // MARK: Main View Controller: Helper methods

    func addButtonMainView(xPosition: CGFloat, width: CGFloat, alpha: CGFloat, text: NSString, viewController: NSViewController) -> NSButton {
        let button = NSButton()

        button.frame = NSMakeRect(xPosition, Constant.WindowLayout.MinimumPaddingButton/1.5, width, Constant.WindowLayout.HeightOfButton)
        button.image = NSImage(named: "background-\(text)-button")
        button.bordered = false
        button.setButtonType(NSButtonType.MomentaryChangeButton)
        button.attributedTitle = TextAttributter.attributedStringForButtons(text.uppercaseString, font: "AvenirNext-DemiBold", color: NSColor.whiteColor())
        button.alphaValue = alpha
        let selectorString = "on\(text.capitalizedString)ButtonPressed"
        button.action = NSSelectorFromString(selectorString)
        button.target = viewController

        viewController.view.addSubview(button)

        return button
    }

    func addBasicTextField(viewController: NSViewController, text: String) -> NSTextField {
        let textField = NSTextField(frame: NSMakeRect(0, 0, 0, 0))
        textField.bezeled = false
        textField.bordered = false
        textField.backgroundColor = NSColor.clearColor()
        textField.textColor = NSColor(calibratedHue:0, saturation:0, brightness:0.2, alpha:1)
        textField.alignment = NSTextAlignment.CenterTextAlignment
        textField.stringValue = text

        viewController.view.addSubview(textField)

        return textField
    }
}
