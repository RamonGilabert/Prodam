import Cocoa

class BreakViewController: NSViewController {

    let viewModel = ViewModel()
    var headerLabel = NSTextField()
    var minutesLabel = NSTextField()
    var editableTextField = NSTextField()
    var realTextField = NSTextField()
    var quoteLabel = NSTextField()
    var authorLabel = NSTextField()
    var workAgainButton = NSButton()
    var startBreakButton = NSButton()
    var closeWindowButton = NSButton()
    var initialFrameMinutes = NSRect()
    var breakTimer = NSTimer()

    // MARK: View lifecycle

    override func loadView() {
        self.view = NSView()
        self.view.frame = NSMakeRect(0, 0, 1200, 700)

        self.headerLabel = self.viewModel.breakLayoutHeaderLabel(self)
        self.editableTextField = self.viewModel.breakLayoutEditableLabel(self)
        self.minutesLabel = self.viewModel.breakLayoutMinutesLabel(self, sideLabel: self.editableTextField)
        self.workAgainButton = self.viewModel.breakLayoutWorkAgainButton(self, sideLabel: self.editableTextField)
        self.startBreakButton = self.viewModel.breakLayoutStartBreakButton(self, sideLabel: self.editableTextField)
        self.closeWindowButton = self.viewModel.breakLayoutCloseButton(self)
        self.quoteLabel = self.viewModel.breakLayoutQuote(self, topButton: self.workAgainButton)
        self.authorLabel = self.viewModel.breakLayoutAuthorQuote(self, authorLabel: self.quoteLabel)

        self.initialFrameMinutes = self.editableTextField.frame
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.makeFirstResponder(self.editableTextField)
    }

    // MARK: Timer methods

    func onLabelShouldChange() {
        if self.editableTextField.stringValue == "00:00" {
            self.breakTimer.invalidate()
            self.editableTextField.editable = true
            self.editableTextField.selectable = true
            self.editableTextField.frame = self.initialFrameMinutes
            self.editableTextField.stringValue = "1"
            self.minutesLabel.hidden = false
            self.view.window?.makeFirstResponder(self.editableTextField)
        } else {
            self.editableTextField.stringValue = DateFormatting.getStringFormattedWithDate(self.editableTextField)
        }
    }

    // MARK: Action handlers

    func onWorkAgainButtonPressed() {
        self.breakTimer.invalidate()
        self.view.window?.close()
    }

    func onStartBreakButtonPressed() {
        if self.startBreakButton.attributedTitle == "START BREAK" || self.startBreakButton.title == "START BREAK" {
            self.minutesLabel.hidden = true
            self.view.window?.makeFirstResponder(nil)
            self.editableTextField.editable = false
            self.editableTextField.selectable = false

            let numberFormatter = NSNumberFormatter()

            if let numberMinutes = numberFormatter.numberFromString(self.editableTextField.stringValue) {
                if numberMinutes.integerValue > 60 {
                    self.editableTextField.stringValue = "59:59"
                } else if numberMinutes.integerValue < 1 {
                    let numberSeconds = Int(numberMinutes.floatValue * 60)

                    if numberSeconds < 10 {
                        self.editableTextField.stringValue = "00:0\(numberSeconds)"
                    } else {
                        self.editableTextField.stringValue = "00:\(numberSeconds)"
                    }
                } else {
                    if numberMinutes.integerValue < 10 {
                        self.editableTextField.stringValue = "0\(numberMinutes.integerValue):00"
                    } else {
                        self.editableTextField.stringValue = "\(numberMinutes.integerValue):00"
                    }
                }

                self.editableTextField.sizeToFit()
                self.editableTextField.frame = NSMakeRect((self.view.frame.width - self.editableTextField.frame.width)/2, self.initialFrameMinutes.origin.y, self.editableTextField.frame.width, self.editableTextField.frame.height)
            }

            self.startBreakButton.attributedTitle = TextAttributter.attributedStringForButtons("PAUSE BREAK", font: "AvenirNext-DemiBold", color: NSColor(calibratedHue:0, saturation:0, brightness:0.22, alpha:1))

            self.breakTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onLabelShouldChange", userInfo: nil, repeats: true)
        } else {
            self.startBreakButton.attributedTitle = TextAttributter.attributedStringForButtons("START BREAK", font: "AvenirNext-DemiBold", color: NSColor(calibratedHue:0, saturation:0, brightness:0.22, alpha:1))
            self.breakTimer.invalidate()
        }
    }

    func onCloseButtonPressed() {
        self.view.window?.close()
    }

    // MARK: Mouse events

    override func mouseDown(theEvent: NSEvent) {
        self.view.window?.makeFirstResponder(nil)
    }
}
