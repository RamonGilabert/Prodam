import Cocoa

struct Constant {
    struct Window {
        static let Width = 300 as CGFloat
        static let Height = 200 as CGFloat
    }

    struct MainWindowLayout {
        static let MinimumPaddingButton = 6 as CGFloat
        static let HeightOfButton = Constant.Window.Height / 3.5
    }
}

class ViewModel: NSObject {

    // MARK: Main View Controller: Layout

    func layoutFunctionalButtonsMainView(viewController: NSViewController) -> NSButton {
        let button = NSButton()
        button.frame = NSMakeRect(Constant.MainWindowLayout.MinimumPaddingButton, Constant.MainWindowLayout.MinimumPaddingButton/1.5, Constant.Window.Width - (2 * Constant.MainWindowLayout.MinimumPaddingButton), Constant.MainWindowLayout.HeightOfButton)
        button.image = NSImage(named: "background-start-button")
        button.bordered = false
        button.setButtonType(NSButtonType.MomentaryChangeButton)
        button.attributedTitle = attributedStringForButtons("START WORKING")
        button.target = viewController
        button.action = "onStartWorkingButtonPressed"

        viewController.view.addSubview(button)

        return button
    }

    func layoutDoneButtonMainView(viewController: NSViewController) -> NSButton {
        let button = NSButton()
        button.frame = NSMakeRect(Constant.MainWindowLayout.MinimumPaddingButton, Constant.MainWindowLayout.MinimumPaddingButton/1.5, Constant.Window.Width/2 - (1.5 * Constant.MainWindowLayout.MinimumPaddingButton), Constant.MainWindowLayout.HeightOfButton)
        button.image = NSImage(named: "background-done-button")
        button.bordered = false
        button.setButtonType(NSButtonType.MomentaryChangeButton)
        button.attributedTitle = attributedStringForButtons("STOP")
        button.target = viewController
        button.action = "onDoneButtonPressed"
        button.alphaValue = 0.0

        viewController.view.addSubview(button)

        return button
    }

    func layoutPauseButtonMainView(viewController: NSViewController) -> NSButton {
        let button = NSButton()

        button.frame = NSMakeRect(Constant.MainWindowLayout.MinimumPaddingButton/2 + Constant.Window.Width/2, Constant.MainWindowLayout.MinimumPaddingButton/1.5, Constant.Window.Width/2 - (1.5 * Constant.MainWindowLayout.MinimumPaddingButton), Constant.MainWindowLayout.HeightOfButton)
        button.image = NSImage(named: "background-pause-button")
        button.bordered = false
        button.setButtonType(NSButtonType.MomentaryChangeButton)
        button.attributedTitle = attributedStringForButtons("PAUSE")
        button.target = viewController
        button.action = "onPauseButtonPressed"
        button.alphaValue = 0.0

        viewController.view.addSubview(button)

        return button
    }

    // MARK: Main View Controller: Helper methods

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
