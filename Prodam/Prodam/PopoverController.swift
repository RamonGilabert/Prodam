import Cocoa
import AVFoundation

protocol Resignator {
    func makeResponder(textField: NSTextField)
}

class PopoverController: NSViewController, NSPopoverDelegate, NSTextFieldDelegate, Resignator {

    let popover = NSPopover()
    let viewModel = ViewModel()
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let audioPlayer = AVAudioPlayer(contentsOfURL: Sound.DoneSound!, error: nil)
    var preferencesWindowController: PreferencesWindowController?
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
    var timerUpdateIcon = NSTimer()
    var breakWindowController: BreakWindowController?
    var popoverManager: PopoverManager?
    var numberOfImagesLeft = 28

    // MARK: View lifecycle

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
        if let numberOfMinutes = NSNumberFormatter().numberFromString(self.editableTimerTextField.stringValue) {
            startingOrStoppingMethods(1.0)
            self.numberOfImagesLeft = 28
            self.taskTextField.removeFromSuperview()
            self.editableTimerTextField.removeFromSuperview()
            self.taskButton.enabled = true

            self.timerTextField.stringValue = DateFormatting.getTextFromNumberOfMinutes(self.editableTimerTextField)

            if self.taskTextField.stringValue == "" {
                self.taskTextField.attributedStringValue = TextSplitter.checkNewStringForTextField("Working hard", fontSize: 18)
            }

            self.userDefaults.setValue(self.taskTextField.stringValue, forKey: "taskTitle")
            self.userDefaults.setValue(self.editableTimerTextField.stringValue, forKey: "taskDuration")
            self.userDefaults.setValue("5", forKey: "taskBreak")
            self.userDefaults.synchronize()

            self.taskTextField.resignFirstResponder()
            self.view.addSubview(self.taskTextField)
            self.addTaskButton.removeFromSuperview()

            self.timerUpdateLabel = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onLabelShouldChange", userInfo: nil, repeats: true)
            self.timerUpdateIcon = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(Float(DateFormatting.getNumberFromDate(self.timerTextField)) / Float(self.numberOfImagesLeft)), target: self, selector: "onIconShouldChange", userInfo: nil, repeats: true)
        } else {
            NSBeep()
        }
    }

    func onStopButtonPressed() {
        stopTimerAndLayoutViews()
    }

    func onPauseButtonPressed() {
        if self.pauseTaskButton.attributedTitle == "PAUSE" || self.pauseTaskButton.title == "PAUSE" {
            self.timerUpdateLabel.invalidate()
            self.timerUpdateIcon.invalidate()
            self.pauseTaskButton.attributedTitle = TextAttributter.attributedStringForButtons("GO", font: "AvenirNext-DemiBold", color: NSColor.whiteColor())
            self.pauseTaskButton.image = NSImage(named: "background-go-button")
        } else {
            self.pauseTaskButton.attributedTitle = TextAttributter.attributedStringForButtons("PAUSE", font: "AvenirNext-DemiBold", color: NSColor.whiteColor())
            self.pauseTaskButton.image = NSImage(named: "background-pause-button")
            self.timerUpdateLabel = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onLabelShouldChange", userInfo: nil, repeats: true)
            self.timerUpdateIcon = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(Float(DateFormatting.getNumberFromDate(self.timerTextField)) / Float(self.numberOfImagesLeft)), target: self, selector: "onIconShouldChange", userInfo: nil, repeats: true)
        }
    }

    func onTasksButtonPressed() {
        stopTimerAndLayoutViews()
        self.taskButton.enabled = false
        self.taskTextField.editable = true
        self.taskTextField.selectable = true
        self.userDefaults.setValue(nil, forKey: "taskTitle")
        self.userDefaults.setValue(nil, forKey: "taskDuration")
        self.userDefaults.setValue(nil, forKey: "taskBreak")
        self.userDefaults.synchronize()
        self.taskTextField.stringValue = ""
        self.editableTimerTextField.stringValue = "50"
        self.pauseTaskButton.attributedTitle = TextAttributter.attributedStringForButtons("PAUSE", font: "AvenirNext-DemiBold", color: NSColor.whiteColor())
        self.pauseTaskButton.image = NSImage(named: "background-pause-button")
    }

    func onSettingsButtonPressed() {
        self.popoverManager?.delegate?.configureThatMenu!()
        self.preferencesWindowController?.popoverManager = self.popoverManager
        self.preferencesWindowController!.loadWindow()
    }

    override func controlTextDidChange(obj: NSNotification) {
        self.taskTextField.attributedStringValue = TextSplitter.checkNewStringForTextField(self.taskTextField.stringValue, fontSize: 18)
    }

    // MARK: Timer methods

    func onRealTimerFired() {
        stopTimerAndLayoutViews()
        self.breakWindowController!.popoverManager = self.popoverManager
        self.breakWindowController!.loadWindow()
        self.numberOfImagesLeft = 28
        if self.userDefaults.boolForKey("soundDone") == true {
            self.audioPlayer.play()
        }
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

    func onIconShouldChange() {
        if self.timerTextField.stringValue == "00:00" {
            onRealTimerFired()
        }
        
        self.popoverManager?.imageView.image = NSImage(named: "logo-\(29 - self.numberOfImagesLeft)")
        self.popoverManager?.imageView.image?.setTemplate(true)
        self.numberOfImagesLeft = self.numberOfImagesLeft - 1
    }

    // MARK: Popover delegate methods

    func popoverWillShow(notification: NSNotification) {
        if self.userDefaults.valueForKey("taskTitle") != nil {
            self.taskButton.enabled = true
            self.taskTextField.editable = false
            self.taskTextField.selectable = false
            self.taskTextField.attributedStringValue = TextSplitter.checkNewStringForTextField(self.userDefaults.stringForKey("taskTitle")!, fontSize: 18)
            self.editableTimerTextField.stringValue = self.userDefaults.stringForKey("taskDuration")!
        } else {
            self.taskButton.enabled = false
            self.taskTextField.editable = true
            self.taskTextField.selectable = true
            self.taskTextField.stringValue = ""
            self.editableTimerTextField.stringValue = "50"
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
        self.taskTextField.editable = (self.userDefaults.valueForKey("taskTitle") != nil) ? false : true
        self.taskTextField.selectable = (self.userDefaults.valueForKey("taskTitle") != nil) ? false : true
        self.doneTaskButton.alphaValue = value
        self.pauseTaskButton.alphaValue = value
        self.pauseTaskButton.attributedTitle = TextAttributter.attributedStringForButtons("PAUSE", font: "AvenirNext-DemiBold", color: NSColor.whiteColor())
        self.pauseTaskButton.image = NSImage(named: "background-pause-button")
    }

    func stopTimerAndLayoutViews() {
        startingOrStoppingMethods(0.0)
        self.view.addSubview(self.editableTimerTextField)
        self.delegate?.makeResponder(self.editableTimerTextField)
        self.taskTextField.attributedStringValue = TextSplitter.checkNewStringForTextField(self.userDefaults.stringForKey("taskTitle")!, fontSize: 18)
        self.view.addSubview(self.addTaskButton)
        self.popoverManager?.imageView.image = NSImage(named: "logo-0")

        self.timerUpdateLabel.invalidate()
        self.timerUpdateIcon.invalidate()
    }

    func makeResponder(textField: NSTextField) { }
    
    func resignAllResponders() { }
}