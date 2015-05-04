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

        self.doneTaskButton.frame = NSMakeRect(Constant.MainWindowLayout.MinimumPaddingButton, Constant.MainWindowLayout.MinimumPaddingButton/1.5, Constant.Window.Width/2 - (1.5 * Constant.MainWindowLayout.MinimumPaddingButton), Constant.MainWindowLayout.HeightOfButton)
        self.doneTaskButton.image = NSImage(named: "background-done-button")
        self.doneTaskButton.bordered = false
        self.doneTaskButton.setButtonType(NSButtonType.MomentaryChangeButton)
        let mutableStringDoneButton = NSMutableAttributedString(string: "STOP")
        mutableStringDoneButton.addAttribute(NSForegroundColorAttributeName, value: NSColor.whiteColor(), range: NSMakeRange(0, mutableStringDoneButton.length))
        mutableStringDoneButton.addAttribute(NSFontAttributeName, value: NSFont(name: "AvenirNext-DemiBold", size: 20)!, range: NSMakeRange(0, mutableStringDoneButton.length))
        let paragraphStyleDoneButton = NSMutableParagraphStyle()
        paragraphStyleDoneButton.alignment = NSTextAlignment.CenterTextAlignment
        mutableStringDoneButton.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyleDoneButton, range: NSMakeRange(0, mutableStringDoneButton.length))
        self.doneTaskButton.attributedTitle = mutableStringDoneButton
        self.doneTaskButton.alphaValue = 0.0

        self.pauseTaskButton.frame = NSMakeRect(Constant.MainWindowLayout.MinimumPaddingButton/2 + Constant.Window.Width/2, Constant.MainWindowLayout.MinimumPaddingButton/1.5, Constant.Window.Width/2 - (1.5 * Constant.MainWindowLayout.MinimumPaddingButton), Constant.MainWindowLayout.HeightOfButton)
        self.pauseTaskButton.image = NSImage(named: "background-pause-button")
        self.pauseTaskButton.bordered = false
        self.pauseTaskButton.setButtonType(NSButtonType.MomentaryChangeButton)
        let mutableStringPauseButton = NSMutableAttributedString(string: "PAUSE")
        mutableStringPauseButton.addAttribute(NSForegroundColorAttributeName, value: NSColor.whiteColor(), range: NSMakeRange(0, mutableStringPauseButton.length))
        mutableStringPauseButton.addAttribute(NSFontAttributeName, value: NSFont(name: "AvenirNext-DemiBold", size: 20)!, range: NSMakeRange(0, mutableStringPauseButton.length))
        let paragraphStylePauseButton = NSMutableParagraphStyle()
        paragraphStylePauseButton.alignment = NSTextAlignment.CenterTextAlignment
        mutableStringPauseButton.addAttribute(NSParagraphStyleAttributeName, value: paragraphStylePauseButton, range: NSMakeRange(0, mutableStringPauseButton.length))
        self.pauseTaskButton.attributedTitle = mutableStringPauseButton
        self.pauseTaskButton.alphaValue = 0.0

        // TODO: Change button to say hey, this is done!
        self.taskButton.frame = NSMakeRect(14, Constant.Window.Height - 26, 21, 13)
        self.taskButton.image = NSImage(named: "todo-button")
        self.taskButton.bordered = false

        self.settingsButton.frame = NSMakeRect(Constant.Window.Width - 34, Constant.Window.Height - 31, 20, 20)
        self.settingsButton.image = NSImage(named: "settings-button")
        self.settingsButton.bordered = false

        self.taskTextField.frame = NSMakeRect(50, Constant.Window.Height - 30, Constant.Window.Width - 100, 22)
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
        self.timerTextField.frame = NSMakeRect((Constant.Window.Width - self.timerTextField.frame.width)/2, (Constant.Window.Height - self.timerTextField.frame.height)/2 + 25, self.timerTextField.frame.width, self.timerTextField.frame.height)
        self.timerTextField.alphaValue = 0.0

        self.editableTimerTextField.frame = NSMakeRect(0, 0, 0, 0)
        self.editableTimerTextField.bezeled = false
        self.editableTimerTextField.bordered = false
        self.editableTimerTextField.backgroundColor = NSColor.clearColor()
        self.editableTimerTextField.textColor = NSColor(calibratedHue:0, saturation:0, brightness:0.2, alpha:1)
        self.editableTimerTextField.alignment = NSTextAlignment.RightTextAlignment
        self.editableTimerTextField.stringValue = "15"
        self.editableTimerTextField.font = NSFont(name: "HelveticaNeue-Bold", size: 70)
        self.editableTimerTextField.sizeToFit()
        self.editableTimerTextField.frame = NSMakeRect((Constant.Window.Width - self.editableTimerTextField.frame.width)/2 - 50, (Constant.Window.Height - self.editableTimerTextField.frame.height)/2 + 20, self.editableTimerTextField.frame.width + 50, self.editableTimerTextField.frame.height)
        self.editableTimerTextField.becomeFirstResponder()
        self.editableTimerTextField.focusRingType = NSFocusRingType.None

        self.minutesLabel.frame = NSMakeRect(0, 0, 0, 0)
        self.minutesLabel.bezeled = false
        self.minutesLabel.bordered = false
        self.minutesLabel.editable = false
        self.minutesLabel.selectable = false
        self.minutesLabel.backgroundColor = NSColor.clearColor()
        self.minutesLabel.textColor = NSColor(calibratedHue:0, saturation:0, brightness:0.2, alpha:1)
        self.minutesLabel.alignment = NSTextAlignment.CenterTextAlignment
        self.minutesLabel.stringValue = "min"
        self.minutesLabel.font = NSFont(name: "AvenirNext-DemiBold", size: 20)
        self.minutesLabel.sizeToFit()
        self.minutesLabel.frame = NSMakeRect(self.editableTimerTextField.frame.origin.x + self.editableTimerTextField.frame.width, self.editableTimerTextField.frame.origin.y + 10, self.minutesLabel.frame.width, self.minutesLabel.frame.height)

        // TODO: Assign first responder here
    }

    // MARK: Action handlers

    func onStartWorkingButtonPressed() {
        if self.addTaskButton.alphaValue > 0.0 {
            self.minutesLabel.alphaValue = 0.0
            self.timerTextField.alphaValue = 1.0
            // FIXME: This needs to be fixed
            self.editableTimerTextField.removeFromSuperview()
            self.taskTextField.editable = false
            self.taskTextField.selectable = false
            self.timerTextField.stringValue = "\(self.editableTimerTextField.stringValue):00"

            if self.taskTextField.stringValue == "" {
                self.taskTextField.stringValue = "Working hard"
            }

            self.addTaskButton.alphaValue = 0.0
            self.doneTaskButton.alphaValue = 1.0
            self.pauseTaskButton.alphaValue = 1.0
        }

        // TODO: Perform animations of the textFields.
        // TODO: Perform animation of the buttons, turning into two buttons.
        // TODO: Resign all first responders.
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
        self.view.addSubview(self.doneTaskButton)
        self.view.addSubview(self.pauseTaskButton)
        self.view.addSubview(self.addTaskButton)
        self.view.addSubview(self.timerTextField)
        self.view.addSubview(self.taskTextField)
        self.view.addSubview(self.editableTimerTextField)
        self.view.addSubview(self.minutesLabel)
    }
}