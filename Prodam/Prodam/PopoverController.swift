import Cocoa

class PopoverController: NSViewController, NSPopoverDelegate {

    let popover = NSPopover()
    let addTaskButton = NSButton()
    let doneTaskButton = NSButton()
    let pauseTaskButton = NSButton()
    let taskButton = NSButton()
    let settingsButton = NSButton()
    let taskTextField = NSTextField()
    let timerTextField = NSTextField()

    override func loadView() {
        self.view = NSView()
        self.view.frame = NSMakeRect(0, 0, Constant.Window.Width, Constant.Window.Height)

        addAllSubviewProperties()
        
        self.popover.contentViewController = self
        self.popover.appearance = NSAppearance(named: NSAppearanceNameVibrantLight)
        self.popover.delegate = self

        self.addTaskButton.frame = NSMakeRect(Constant.MainWindowLayout.MinimumPaddingButton, Constant.MainWindowLayout.MinimumPaddingButton/1.5, Constant.Window.Width - (2 * Constant.MainWindowLayout.MinimumPaddingButton), Constant.MainWindowLayout.HeightOfButton)
        self.addTaskButton.image = NSImage(named: "background-start-button")
        self.addTaskButton.bordered = false
        self.addTaskButton.setButtonType(NSButtonType.MomentaryChangeButton)
        let mutableStringAddTaskButton = NSMutableAttributedString(string: "START WORKING")
        mutableStringAddTaskButton.addAttribute(NSForegroundColorAttributeName, value: NSColor.whiteColor(), range: NSMakeRange(0, mutableStringAddTaskButton.length))
        mutableStringAddTaskButton.addAttribute(NSFontAttributeName, value: NSFont(name: "AvenirNext-DemiBold", size: 20)!, range: NSMakeRange(0, mutableStringAddTaskButton.length))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.CenterTextAlignment
        mutableStringAddTaskButton.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, mutableStringAddTaskButton.length))
        self.addTaskButton.attributedTitle = mutableStringAddTaskButton

        self.taskButton.frame = NSMakeRect(14, Constant.Window.Height - 26, 21, 13)
        self.taskButton.image = NSImage(named: "todo-button")
        self.taskButton.bordered = false

        self.settingsButton.frame = NSMakeRect(Constant.Window.Width - 34, Constant.Window.Height - 30, 20, 20)
        self.settingsButton.image = NSImage(named: "settings-button")
        self.settingsButton.bordered = false

        self.taskTextField.frame = NSMakeRect(0, 0, 0, 0)
        self.taskTextField.bordered = false
        self.taskTextField.alignment = NSTextAlignment.CenterTextAlignment
        self.taskTextField.placeholderString = "Enter your new task..."
        self.taskTextField.font = NSFont(name: "HelveticaNeue", size: 19)
    }

    // MARK: Helper methods

    func addAllSubviewProperties() {
        self.view.addSubview(self.addTaskButton)
        self.view.addSubview(self.doneTaskButton)
        self.view.addSubview(self.pauseTaskButton)
        self.view.addSubview(self.taskButton)
        self.view.addSubview(self.settingsButton)
        self.view.addSubview(self.taskTextField)
        self.view.addSubview(self.timerTextField)
    }
}