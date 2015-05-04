import Cocoa

class PopoverController: NSViewController, NSPopoverDelegate, NSTextViewDelegate {

    let popover = NSPopover()
    let addTaskButton = NSButton()
    let doneTaskButton = NSButton()
    let pauseTaskButton = NSButton()
    let taskButton = NSButton()
    let settingsButton = NSButton()
    let taskTextField = NSTextField()
    let timerTextField = NSTextField()
    let editableTimerTextField = NSTextField()
    let minutesLabel = NSTextField()

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
        self.addTaskButton.target = self
        self.addTaskButton.action = "onStartWorkingButtonPressed"

        self.taskButton.frame = NSMakeRect(14, Constant.Window.Height - 26, 21, 13)
        self.taskButton.image = NSImage(named: "todo-button")
        self.taskButton.bordered = false

        self.settingsButton.frame = NSMakeRect(Constant.Window.Width - 34, Constant.Window.Height - 31, 20, 20)
        self.settingsButton.image = NSImage(named: "settings-button")
        self.settingsButton.bordered = false

        self.taskTextField.frame = NSMakeRect(50, Constant.Window.Height - 31, Constant.Window.Width - 100, 22)
        self.taskTextField.bezeled = false
        self.taskTextField.bordered = false
        self.taskTextField.backgroundColor = NSColor.clearColor()
        self.taskTextField.textColor = NSColor(calibratedHue:0, saturation:0, brightness:0.2, alpha:1)
        self.taskTextField.alignment = NSTextAlignment.CenterTextAlignment
        self.taskTextField.placeholderString = "Enter your new task..."
        self.taskTextField.font = NSFont(name: "HelveticaNeue", size: 18)
        self.taskTextField.focusRingType = NSFocusRingType.None

        self.timerTextField.frame = NSMakeRect(40, Constant.Window.Height/4 + 30, Constant.Window.Width - 80, 0)
        self.timerTextField.bezeled = false
        self.timerTextField.bordered = false
        self.timerTextField.editable = false
        self.timerTextField.selectable = false
        self.timerTextField.backgroundColor = NSColor.clearColor()
        self.timerTextField.textColor = NSColor(calibratedHue:0, saturation:0, brightness:0.2, alpha:1)
        self.timerTextField.alignment = NSTextAlignment.CenterTextAlignment
        self.timerTextField.stringValue = "15:00"
        self.timerTextField.font = NSFont(name: "AvenirNextCondensed-DemiBold", size: 85)
        self.timerTextField.sizeToFit()
        self.timerTextField.frame = NSMakeRect((Constant.Window.Width - self.timerTextField.frame.width)/2, (Constant.Window.Height - self.timerTextField.frame.height)/2 + 22.5, self.timerTextField.frame.width, self.timerTextField.frame.height)
        self.timerTextField.alphaValue = 0.0
    }

    // MARK: Action handlers

    func onStartWorkingButtonPressed() {

    }

    // MARK: NSTextView delegate methods

    func textView(textView: NSTextView, shouldChangeTextInRanges affectedRanges: [AnyObject], replacementStrings: [AnyObject]?) -> Bool {
        let stringChanged = replacementStrings?.first as! String
        if stringChanged == "\n" {
            return false
        }

        return true
    }

    // MARK: Helper methods

    func addAllSubviewProperties() {
        self.view.addSubview(self.taskButton)
        self.view.addSubview(self.settingsButton)
        self.view.addSubview(self.timerTextField)
        self.view.addSubview(self.taskTextField)
        self.view.addSubview(self.addTaskButton)
        self.view.addSubview(self.doneTaskButton)
        self.view.addSubview(self.pauseTaskButton)
        self.view.addSubview(self.editableTimerTextField)
        self.view.addSubview(self.minutesLabel)
    }
}