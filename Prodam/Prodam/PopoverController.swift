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

    override func loadView() {
        self.view = NSView()
        self.view.frame = NSMakeRect(0, 0, Constant.Window.Width, Constant.Window.Height)
        
        self.popover.contentViewController = self
        self.popover.appearance = NSAppearance(named: NSAppearanceNameVibrantLight)
        self.popover.delegate = self

        self.doneTaskButton = self.viewModel.layoutDoneButtonMainView(self)
        self.pauseTaskButton = self.viewModel.layoutPauseButtonMainView(self)
        self.addTaskButton = self.viewModel.layoutFunctionalButtonsMainView(self)
        self.taskTextField = self.viewModel.layoutTaskTextFieldMainView(self, viewController: self)
        self.timerTextField = self.viewModel.layoutTimerTextFieldMainView(self)
        self.editableTimerTextField = self.viewModel.layoutEditableTextFieldMainView(self)
        self.minutesLabel = self.viewModel.layoutMinutesTextFieldMainView(self, editableTextField: self.editableTimerTextField)
        self.taskButton = self.viewModel.layoutButtonTasksMainView(self)
        self.settingsButton = self.viewModel.layoutButtonSettingsMainView(self)
    }

    // MARK: Action handlers

    func onStartButtonPressed() {
        self.minutesLabel.alphaValue = 0.0
        self.timerTextField.alphaValue = 1.0
        self.taskTextField.removeFromSuperview()
        self.editableTimerTextField.removeFromSuperview()
        self.taskTextField.editable = false
        self.taskTextField.selectable = false
        self.timerTextField.stringValue = "\(self.editableTimerTextField.stringValue):00"

        if self.taskTextField.stringValue == "" {
            self.taskTextField.attributedStringValue = checkNewStringForTextField("Working hard")
        }

        self.view.addSubview(self.taskTextField)
        self.addTaskButton.removeFromSuperview()
        self.doneTaskButton.alphaValue = 1.0
        self.pauseTaskButton.alphaValue = 1.0

        // TODO: Perform animations of the textFields.
        // TODO: Perform animation of the buttons, turning into two buttons.
        // TODO: Resign all first responders.
    }

    func onStopButtonPressed() {
        self.minutesLabel.alphaValue = 1.0
        self.timerTextField.alphaValue = 0.0
        self.view.addSubview(self.editableTimerTextField)
        self.taskTextField.editable = true
        self.taskTextField.selectable = true
        self.delegate?.makeResponder(self.editableTimerTextField)
        self.taskTextField.stringValue = ""
        self.view.addSubview(self.addTaskButton)
        self.doneTaskButton.alphaValue = 0.0
        self.pauseTaskButton.alphaValue = 0.0
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
        self.taskTextField.attributedStringValue = checkNewStringForTextField(self.taskTextField.stringValue)
    }

    // MARK: Helper methods

    func makeResponder(textField: NSTextField) { }
}