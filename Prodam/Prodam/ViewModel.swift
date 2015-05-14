import Cocoa

struct Constant {
    struct Window {
        static let Width = 300 as CGFloat
        static let Height = 190 as CGFloat
    }

    struct WindowLayout {
        static let MinimumPaddingButton = 6 as CGFloat
        static let HeightOfButton = Constant.Window.Height / 4
        static let WidthDonePauseButtons = Constant.Window.Width/2 - (1.5 * Constant.WindowLayout.MinimumPaddingButton)
        static let WidthMainButton = Constant.Window.Width - (2 * Constant.WindowLayout.MinimumPaddingButton)
        static let HalfScreenPadding = Constant.WindowLayout.MinimumPaddingButton/2 + Constant.Window.Width/2
        static let SizeHelperButtons = 20 as CGFloat
    }

    struct BreakLayout {
        static let WidthMainView = 1200 as CGFloat
        static let HeightMainView = 700 as CGFloat
        static let WidthMainButton = 265 as CGFloat
        static let HeightMainButton = 55 as CGFloat
        static let TopEditableYPadding = 65 as CGFloat
        static let PaddingXButton = 25 as CGFloat
        static let PaddingYButton = 115 as CGFloat
        static let SizeCloseButton = 17 as CGFloat
        static let AlphaValueTextFields = 0.6 as CGFloat
        static let AlphaValueButtons = 0.8 as CGFloat
        static let MinutesLabelXPadding = 15 as CGFloat
        static let MinutesLabelYPadding = 55 as CGFloat
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
        textField.font = NSFont_Prodam.textFieldNormalField()
        textField.focusRingType = NSFocusRingType.None
        textField.allowsEditingTextAttributes = true
        textField.delegate = fieldDelegate

        viewController.view.addSubview(textField)

        return textField
    }

    func layoutTimerTextFieldMainView(viewController: NSViewController) -> NSTextField {
        let textField = addBasicTextField(viewController, text: "50:00")
        textField.editable = false
        textField.selectable = false
        textField.font = NSFont_Prodam.mainTimer()
        textField.sizeToFit()
        textField.frame = NSMakeRect((Constant.Window.Width - (textField.frame.width + 100))/2, (Constant.Window.Height - textField.frame.height)/2 + 20, textField.frame.width + 100, textField.frame.height)
        textField.alphaValue = 0.0

        return textField
    }

    func layoutEditableTextFieldMainView(viewController: NSViewController) -> NSTextField {
        let textField = addBasicTextField(viewController, text: "50")
        textField.alignment = NSTextAlignment.RightTextAlignment
        textField.font = NSFont_Prodam.mainTimerEditable()
        textField.sizeToFit()
        textField.frame = NSMakeRect((Constant.Window.Width - textField.frame.width)/2 - 100, (Constant.Window.Height - textField.frame.height)/2 + 10, textField.frame.width + 100, textField.frame.height)
        textField.becomeFirstResponder()
        textField.focusRingType = NSFocusRingType.None

        return textField
    }

    func layoutMinutesTextFieldMainView(viewController: NSViewController, editableTextField: NSTextField) -> NSTextField {
        let textField = addBasicTextField(viewController, text: "min")
        textField.editable = false
        textField.selectable = false
        textField.font = NSFont_Prodam.mainMinutesTextField()
        textField.sizeToFit()
        textField.frame = NSMakeRect(editableTextField.frame.origin.x + editableTextField.frame.width, editableTextField.frame.origin.y + 5, textField.frame.width, textField.frame.height)

        return textField
    }

    func layoutButtonTasksMainView(viewController: NSViewController) -> NSButton {
        let button = NSButton(frame: NSMakeRect(14, Constant.Window.Height - 30, Constant.WindowLayout.SizeHelperButtons, Constant.WindowLayout.SizeHelperButtons))
        button.image = NSImage(named: "done-button")
        button.bordered = false
        button.target = viewController
        button.action = "onTasksButtonPressed"
        button.enabled = false

        viewController.view.addSubview(button)

        return button
    }

    func layoutButtonSettingsMainView(viewController: NSViewController) -> NSButton {
        let button = NSButton(frame: NSMakeRect(Constant.Window.Width - 34, Constant.Window.Height - 30, Constant.WindowLayout.SizeHelperButtons, Constant.WindowLayout.SizeHelperButtons))
        button.image = NSImage(named: "settings-button")
        button.bordered = false
        button.target = viewController
        button.action = "onSettingsButtonPressed"

        viewController.view.addSubview(button)

        return button
    }

    // MARK: Break View Controller: Layout

    func breakLayoutHeaderLabel(viewController: NSViewController) -> NSTextField {
        var label = addBasicTextField(viewController, text: "TAKING A BREAK")
        label = addBreakLabelConfiguration(label, font: NSFont_Prodam.breakHeaderTextField())
        label.frame = NSMakeRect((viewController.view.frame.width - label.frame.width)/2, viewController.view.frame.height - label.frame.height - 25, label.frame.width, label.frame.height)

        return label
    }

    func breakLayoutEditableLabel(viewController: NSViewController) -> NSTextField {
        var label = addBasicTextField(viewController, text: "5")
        label = addBreakLabelConfiguration(label, font: NSFont_Prodam.breakTimerFont())
        label.alignment = NSTextAlignment.RightTextAlignment
        label.editable = true
        label.frame = NSMakeRect((viewController.view.frame.width - label.frame.width*4.75)/2, (viewController.view.frame.height - label.frame.height)/2 + Constant.BreakLayout.TopEditableYPadding, label.frame.width * 3, label.frame.height)

        return label
    }

    func breakLayoutMinutesLabel(viewController: NSViewController, sideLabel: NSTextField) -> NSTextField {
        var label = addBasicTextField(viewController, text: "min")
        label = addBreakLabelConfiguration(label, font: NSFont_Prodam.breakMinutesFont())
        label.frame = NSMakeRect(sideLabel.frame.origin.x + sideLabel.frame.width + Constant.BreakLayout.MinutesLabelXPadding, sideLabel.frame.origin.y + Constant.BreakLayout.MinutesLabelYPadding, label.frame.width, label.frame.height)

        return label
    }

    func breakLayoutWorkAgainButton(viewController: NSViewController, sideLabel: NSTextField) -> NSButton {
        var button = NSButton(frame: NSMakeRect((viewController.view.frame.width / 2) - (Constant.BreakLayout.PaddingXButton + Constant.BreakLayout.WidthMainButton), sideLabel.frame.origin.y - Constant.BreakLayout.PaddingYButton, Constant.BreakLayout.WidthMainButton, Constant.BreakLayout.HeightMainButton))
        button.image = NSImage(named: "background-break-button")
        button = addButtonConfiguration(button, viewController: viewController, text: "WORK AGAIN", color: NSColor(calibratedHue:0, saturation:0, brightness:0.22, alpha:1))
        button.action = "onWorkAgainButtonPressed"

        return button
    }

    func breakLayoutStartBreakButton(viewController: NSViewController, sideLabel: NSTextField) -> NSButton {
        var button = NSButton(frame: NSMakeRect((viewController.view.frame.width / 2) + Constant.BreakLayout.PaddingXButton, sideLabel.frame.origin.y - Constant.BreakLayout.PaddingYButton, Constant.BreakLayout.WidthMainButton, Constant.BreakLayout.HeightMainButton))
        button.image = NSImage(named: "background-break-button")
        button = addButtonConfiguration(button, viewController: viewController, text: "START BREAK", color: NSColor(calibratedHue:0, saturation:0, brightness:0.22, alpha:1))
        button.action = "onStartBreakButtonPressed"

        return button
    }

    func breakLayoutCloseButton(viewController: NSViewController) -> NSButton {
        var button = NSButton(frame: NSMakeRect(Constant.BreakLayout.SizeCloseButton, viewController.view.frame.height - (Constant.BreakLayout.SizeCloseButton * 2), Constant.BreakLayout.SizeCloseButton, Constant.BreakLayout.SizeCloseButton))
        button = addButtonConfiguration(button, viewController: viewController, text: "", color: NSColor.whiteColor())
        button.image = NSImage(named: "close-break-button")
        button.action = "onCloseButtonPressed"

        return button
    }

    func breakLayoutQuote(viewController: NSViewController, topButton: NSButton, randomNumber: Int) -> NSTextField {
        var label = addBasicTextField(viewController, text: Quote.ArrayOfQuotes[randomNumber]["quote"]!)
        label = addBreakLabelConfiguration(label, font: NSFont_Prodam.breakQuoteFont())
        label.frame = NSMakeRect((viewController.view.frame.width - label.frame.width)/2, (topButton.frame.origin.y - label.frame.height)/2 + label.frame.height/2, label.frame.width, label.frame.height)

        return label
    }

    func breakLayoutAuthorQuote(viewController: NSViewController, authorLabel: NSTextField, randomNumber: Int) -> NSTextField {
        var label = addBasicTextField(viewController, text: Quote.ArrayOfQuotes[randomNumber]["author"]!)
        label = addBreakLabelConfiguration(label, font: NSFont_Prodam.breakAuthorFont())
        label.frame = NSMakeRect(authorLabel.frame.origin.x + authorLabel.frame.width - label.frame.width, authorLabel.frame.origin.y - label.frame.height, label.frame.width, label.frame.height)

        return label
    }

    // MARK: Preferences View Controller: Layout

    func layoutPreferencesView(view: NSView, viewController: NSViewController) {
        layoutPreferencesLabel("Preferences", view: view)
        let separatorView = layoutSeparatorView(view, frame: NSMakeRect(0, view.frame.height - 42.5, view.frame.width, 1))
        let generalLabel = layoutGeneralLabelPreferences("General", view: view, separatorView: separatorView)
        layoutLaunchLogin("Launch at login", view: view, separatorView: separatorView, anotherTextField: generalLabel)
        let soundDoneLabel = layoutSoundWhenDonePreferences("Play notification sound", view: view, separatorView: separatorView, labelGeneral: generalLabel)
        let separatorViewBottom = layoutSeparatorView(view, frame: NSMakeRect(0, soundDoneLabel.frame.origin.y - 30, view.frame.width, 1))
        layoutFirstButtonPreferences(view, viewController: viewController)
        layoutSecondButtonPreferences(view, viewController: viewController)
        let labelName = layoutNameLabel(view, bottomSeparator: separatorViewBottom)
    }

    func layoutPreferencesLabel(text: String, view: NSView) -> NSTextField {
        let textField = layoutBasicTextField()
        textField.stringValue = text
        textField.font = NSFont(name: "Helvetica Neue", size: 18)
        textField.alignment = NSTextAlignment.CenterTextAlignment
        textField.sizeToFit()
        textField.frame = NSMakeRect((view.frame.width - textField.frame.width)/2, view.frame.height - textField.frame.height - 10, textField.frame.width, textField.frame.height)
        view.addSubview(textField)

        return textField
    }

    func layoutSeparatorView(view: NSView, frame: NSRect) -> NSView {
        let separatorView = NSView(frame: frame)
        separatorView.wantsLayer = true
        separatorView.layer?.backgroundColor = NSColor.lightGrayColor().CGColor
        view.addSubview(separatorView)

        return separatorView
    }

    func layoutGeneralLabelPreferences(text: String, view: NSView, separatorView: NSView) -> NSTextField {
        let textField = layoutBasicTextField()
        textField.stringValue = text
        textField.textColor = NSColor(calibratedHue:0.67, saturation:0.06, brightness:0.49, alpha:1)
        textField.font = NSFont(name: "Helvetica Neue", size: 15)
        textField.alignment = NSTextAlignment.CenterTextAlignment
        textField.sizeToFit()
        textField.frame = NSMakeRect(100, separatorView.frame.origin.y - 40, textField.frame.width, textField.frame.height)
        view.addSubview(textField)

        return textField
    }

    func layoutLaunchLogin(text: String, view: NSView, separatorView: NSView, anotherTextField: NSTextField) {
        let textField = layoutBasicTextField()
        textField.stringValue = text
        textField.textColor = NSColor(calibratedHue:1, saturation:0.04, brightness:0.19, alpha:1)
        textField.font = NSFont(name: "Helvetica Neue", size: 15)
        textField.alignment = NSTextAlignment.CenterTextAlignment
        textField.sizeToFit()
        textField.frame = NSMakeRect(150 + anotherTextField.frame.width, separatorView.frame.origin.y - 40, textField.frame.width, textField.frame.height)
        view.addSubview(textField)
    }

    func layoutSoundWhenDonePreferences(text: String, view: NSView, separatorView: NSView, labelGeneral: NSTextField) -> NSTextField {
        let textField = layoutBasicTextField()
        textField.stringValue = text
        textField.textColor = NSColor(calibratedHue:1, saturation:0.04, brightness:0.19, alpha:1)
        textField.font = NSFont(name: "Helvetica Neue", size: 15)
        textField.alignment = NSTextAlignment.CenterTextAlignment
        textField.sizeToFit()
        textField.frame = NSMakeRect(150 + labelGeneral.frame.width, separatorView.frame.origin.y - 80, textField.frame.width, textField.frame.height)
        view.addSubview(textField)

        return textField
    }

    func layoutNameLabel(view: NSView, bottomSeparator: NSView) -> NSTextField {
        let textField = layoutBasicTextField()
        textField.attributedStringValue = TextSplitter.checkNewStringForTextField("Ramon Gilabert", fontSize: 25)
        textField.sizeToFit()
        textField.frame = NSMakeRect((view.frame.width - textField.frame.width)/2, bottomSeparator.frame.origin.y - textField.frame.height - 25, textField.frame.width, textField.frame.height)
        view.addSubview(textField)

        return textField
    }

    func layoutFirstButtonPreferences(view: NSView, viewController: NSViewController) {
        let button = layoutBasicButton(NSMakeRect(12, view.frame.height - 28, 16, 16), image: "button-close-preferences", viewController: viewController)
        button.action = "onClosePreferencesButtonPressed"
        view.addSubview(button)
    }

    func layoutSecondButtonPreferences(view: NSView, viewController: NSViewController) {
        let button = layoutBasicButton(NSMakeRect(view.frame.width - 29, view.frame.height - 28, 17, 18), image: "button-quit-preferences", viewController: viewController)
        button.action = "onQuitAppButtonPressed"
        view.addSubview(button)
    }

    func layoutSocialButtons(view: NSView, viewController: NSViewController, labelName: NSTextField) {
        let buttonTwitter = layoutBasicButton(NSMakeRect((view.frame.width - 64)/2 - 100, labelName.frame.origin.y - 83, 64, 66), image: "twitter-icon-social", viewController: viewController)
        buttonTwitter.action = "onTwitterButtonPressed"
        view.addSubview(buttonTwitter)

        let buttonWebsite = layoutBasicButton(NSMakeRect((view.frame.width - 64)/2 + 100, labelName.frame.origin.y - 83, 64, 66), image: "dribbble-icon-social", viewController: viewController)
        buttonWebsite.action = "onDribbbleButtonPressed"
        view.addSubview(buttonWebsite)

        let buttonEmail = layoutBasicButton(NSMakeRect((view.frame.width - 64)/2, labelName.frame.origin.y - 83, 64, 66), image: "email-icon-social", viewController: viewController)
        buttonEmail.action = "onEmailButtonPressed"
        view.addSubview(buttonEmail)
    }

    // MARK: Preferences View Controller: Helper methods

    func layoutBasicTextField() -> NSTextField {
        let textField = NSTextField()
        textField.bordered = false
        textField.bezeled = false
        textField.editable = false
        textField.selectable = false
        textField.drawsBackground = false
        textField.textColor = NSColor(calibratedHue:0, saturation:0, brightness:0.16, alpha:1)

        return textField
    }

    func layoutBasicButton(frame: NSRect, image: String, viewController: NSViewController) -> NSButton {
        let button = NSButton(frame: frame)
        button.bordered = false
        button.setButtonType(NSButtonType.MomentaryChangeButton)
        button.target = viewController

        return button
    }

    // MARK: Main View Controller: Helper methods

    func addButtonMainView(xPosition: CGFloat, width: CGFloat, alpha: CGFloat, text: NSString, viewController: NSViewController) -> NSButton {
        var button = NSButton(frame: NSMakeRect(xPosition, Constant.WindowLayout.MinimumPaddingButton, width, Constant.WindowLayout.HeightOfButton))
        button.image = NSImage(named: "background-\(text)-button")
        button = addButtonConfiguration(button, viewController: viewController, text: text.uppercaseString, color: NSColor.whiteColor())
        button.alphaValue = alpha
        button.action = NSSelectorFromString("on\(text.capitalizedString)ButtonPressed")

        return button
    }

    func addBreakLabelConfiguration(label: NSTextField, font: NSFont) -> NSTextField {
        label.editable = false
        label.selectable = false
        label.textColor = NSColor_Prodam.colorBreakLabels()
        label.alphaValue = Constant.BreakLayout.AlphaValueTextFields
        label.focusRingType = NSFocusRingType.None
        label.font = font
        label.alignment = NSTextAlignment.CenterTextAlignment
        label.sizeToFit()

        return label
    }

    func addButtonConfiguration(button: NSButton, viewController: NSViewController, text: String, color: NSColor) -> NSButton {
        button.bordered = false
        button.attributedTitle = TextAttributter.attributedStringForButtons(text, font: "AvenirNext-DemiBold", color: color)
        button.setButtonType(NSButtonType.MomentaryChangeButton)
        button.alphaValue = Constant.BreakLayout.AlphaValueButtons
        button.target = viewController

        viewController.view.addSubview(button)

        return button
    }

    func addBasicTextField(viewController: NSViewController, text: String) -> NSTextField {
        let textField = NSTextField(frame: NSMakeRect(0, 0, 0, 0))
        textField.bezeled = false
        textField.bordered = false
        textField.drawsBackground = false
        textField.textColor = NSColor_Prodam.almostBlackColor()
        textField.alignment = NSTextAlignment.CenterTextAlignment
        textField.stringValue = text

        viewController.view.addSubview(textField)

        return textField
    }
}
