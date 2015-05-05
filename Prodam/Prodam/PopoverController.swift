import Cocoa

protocol Resignator {
    func makeResponder(textField: NSTextField)
    func resignAllResponders()
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
        self.timerTextField.stringValue = "\(self.editableTimerTextField.stringValue):00"

        if self.taskTextField.stringValue == "" {
            self.taskTextField.attributedStringValue = TextSplitter.checkNewStringForTextField("Working hard")
        }

        self.taskTextField.resignFirstResponder()
        self.view.addSubview(self.taskTextField)
        self.addTaskButton.removeFromSuperview()

        // TODO: Resign all first responders.
    }

    func onStopButtonPressed() {
        startingOrStoppingMethods(0.0)
        self.view.addSubview(self.editableTimerTextField)
        self.delegate?.makeResponder(self.editableTimerTextField)
        self.taskTextField.stringValue = ""
        self.view.addSubview(self.addTaskButton)
        // TODO: Delete the timer
    }

    func onPauseButtonPressed() {
        // TODO: Pause the timer
    }

    func onTasksButtonPressed() {

    }

    func onSettingsButtonPressed() {
        
    }

    override func controlTextDidChange(obj: NSNotification) {
        self.taskTextField.attributedStringValue = TextSplitter.checkNewStringForTextField(self.taskTextField.stringValue)
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

    func makeResponder(textField: NSTextField) { }
    func resignAllResponders() { }
}