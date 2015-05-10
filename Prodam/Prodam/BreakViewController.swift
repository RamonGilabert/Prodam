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

        let randomNumber = Int(arc4random() % 15)

        self.headerLabel = self.viewModel.breakLayoutHeaderLabel(self)
        self.editableTextField = self.viewModel.breakLayoutEditableLabel(self)
        self.minutesLabel = self.viewModel.breakLayoutMinutesLabel(self, sideLabel: self.editableTextField)
        self.workAgainButton = self.viewModel.breakLayoutWorkAgainButton(self, sideLabel: self.editableTextField)
        self.startBreakButton = self.viewModel.breakLayoutStartBreakButton(self, sideLabel: self.editableTextField)
        self.closeWindowButton = self.viewModel.breakLayoutCloseButton(self)
        self.quoteLabel = self.viewModel.breakLayoutQuote(self, topButton: self.workAgainButton, randomNumber: randomNumber)
        self.authorLabel = self.viewModel.breakLayoutAuthorQuote(self, authorLabel: self.quoteLabel, randomNumber: randomNumber)

        self.initialFrameMinutes = self.editableTextField.frame
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.makeFirstResponder(self.editableTextField)
    }

    // MARK: Timer methods

    func onLabelShouldChange() {
        if self.editableTextField.stringValue == "00:00" {
            self.headerLabel.stringValue = "TAKE ANOTHER BREAK"
            self.headerLabel.sizeToFit()
            self.headerLabel.frame = NSMakeRect((self.view.frame.width - self.headerLabel.frame.width)/2, self.headerLabel.frame.origin.y, self.headerLabel.frame.width, self.headerLabel.frame.height)
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
            self.editableTextField.stringValue = DateFormatting.getTextWithoutBiggerThanMinutes(self.editableTextField)
            self.editableTextField.sizeToFit()
            self.editableTextField.frame = NSMakeRect((self.view.frame.width - self.editableTextField.frame.width)/2, self.initialFrameMinutes.origin.y, self.editableTextField.frame.width, self.editableTextField.frame.height)

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
