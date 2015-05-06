import Cocoa

protocol Resignator {
    func makeResponder(textField: NSTextField)
}

class PopoverController: NSViewController, NSPopoverDelegate, NSTextFieldDelegate, Resignator {

    let popover = NSPopover()
    let viewModel = ViewModel()
    var addTaskButton = NSButton()
    var doneTaskButton = NSButton()
    var pauseTaskButton = NSButton()
    var taskButton = NSButton()
    var settingsButton = NSButton()
    var taskTextField = NSTextField()
    var timerTextField = NSTextField()
    var editableTimerTextField = NSTextField()
    var minutesLabel = NSTextField()
    var delegate: Resignator?
    var timerUpdateLabel = NSTimer()

    override func loadView() {
        self.view = NSView()
        self.view.frame = NSMakeRect(0, 0, Constant.Window.Width, Constant.Window.Height)
        
        self.popover.contentViewController = self
        self.popover.appearance = NSAppearance(named: NSAppearanceNameVibrantLight)
        self.popover.delegate = self

        handleLayout()
    }

    // MARK: Action handlers

    func onStartButtonPressed() {
        startingOrStoppingMethods(1.0)
        self.taskTextField.removeFromSuperview()
        self.editableTimerTextField.removeFromSuperview()
        self.taskButton.enabled = true

        self.timerTextField.stringValue = DateFormatting.getTextFromNumberOfMinutes(self.editableTimerTextField)

        if self.taskTextField.stringValue == "" {
            self.taskTextField.attributedStringValue = TextSplitter.checkNewStringForTextField("Working hard")
        }

        self.taskTextField.resignFirstResponder()
        self.view.addSubview(self.taskTextField)
        self.addTaskButton.removeFromSuperview()

        self.timerUpdateLabel = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onLabelShouldChange", userInfo: nil, repeats: true)
    }

    func onStopButtonPressed() {
        stopTimerAndLayoutViews()
    }

    func onPauseButtonPressed() {
        if self.pauseTaskButton.attributedTitle == "PAUSE" || self.pauseTaskButton.title == "PAUSE" {
            self.timerUpdateLabel.invalidate()
            self.pauseTaskButton.attributedTitle = TextAttributter.attributedStringForButtons("GO")
            self.pauseTaskButton.image = NSImage(named: "background-go-button")
        } else {
            self.pauseTaskButton.attributedTitle = TextAttributter.attributedStringForButtons("PAUSE")
            self.pauseTaskButton.image = NSImage(named: "background-pause-button")
            self.timerUpdateLabel = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onLabelShouldChange", userInfo: nil, repeats: true)
        }
    }

    func onTasksButtonPressed() {
        stopTimerAndLayoutViews()
        // TODO: Delete from CoreData
    }

    func onSettingsButtonPressed() {
        // TODO: Show preferences
    }

    override func controlTextDidChange(obj: NSNotification) {
        self.taskTextField.attributedStringValue = TextSplitter.checkNewStringForTextField(self.taskTextField.stringValue)
    }

    // MARK: Timer methods

    func onRealTimerFired() {
        self.timerUpdateLabel.invalidate()
        // TODO: Show new window with break!
    }

    func onLabelShouldChange() {

        if self.timerTextField.stringValue == "1:00:00" || self.timerTextField.stringValue == "01:00:00" {
            self.timerTextField.stringValue = "59:59"
        } else {
            self.timerTextField.stringValue = DateFormatting.getStringFormattedWithDate(self.timerTextField)

            if self.timerTextField.stringValue == "00:00" {
                onRealTimerFired()
            }
        }
    }

    // MARK: Mouse events

    override func mouseDown(theEvent: NSEvent) {
        self.view.window?.makeFirstResponder(nil)
    }

    // MARK: Helper methods

    func handleLayout() {
        self.doneTaskButton = self.viewModel.layoutDoneButtonMainView(self)
        self.pauseTaskButton = self.viewModel.layoutPauseButtonMainView(self)
        self.addTaskButton = self.viewModel.layoutFunctionalButtonsMainView(self)
        self.timerTextField = self.viewModel.layoutTimerTextFieldMainView(self)
        self.taskTextField = self.viewModel.layoutTaskTextFieldMainView(self, viewController: self)
        self.editableTimerTextField = self.viewModel.layoutEditableTextFieldMainView(self)
        self.minutesLabel = self.viewModel.layoutMinutesTextFieldMainView(self, editableTextField: self.editableTimerTextField)
        self.taskButton = self.viewModel.layoutButtonTasksMainView(self)
        self.settingsButton = self.viewModel.layoutButtonSettingsMainView(self)
    }

    func startingOrStoppingMethods(value: CGFloat) {
        self.minutesLabel.alphaValue = 1.0 - value
        self.timerTextField.alphaValue = value
        self.taskTextField.editable = Bool(1.0 - value)
        self.taskTextField.selectable = Bool(1.0 - value)
        self.doneTaskButton.alphaValue = value
        self.pauseTaskButton.alphaValue = value
    }

    func stopTimerAndLayoutViews() {
        startingOrStoppingMethods(0.0)
        self.view.addSubview(self.editableTimerTextField)
        self.delegate?.makeResponder(self.editableTimerTextField)
        self.taskTextField.stringValue = ""
        self.view.addSubview(self.addTaskButton)
        self.taskButton.enabled = false

        self.timerUpdateLabel.invalidate()
    }

    func makeResponder(textField: NSTextField) { }
    
    func resignAllResponders() { }
}