import Cocoa

class BreakViewController: NSViewController {

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

    override func loadView() {
        self.view = NSView()
        self.view.frame = NSMakeRect(0, 0, 1200, 700)

        self.headerLabel.frame = NSMakeRect(0, 0, 0, 0)
        self.headerLabel.bordered = false
        self.headerLabel.bezeled = false
        self.headerLabel.editable = false
        self.headerLabel.selectable = false
        self.headerLabel.drawsBackground = false
        self.headerLabel.stringValue = "TAKING A BREAK"
        self.headerLabel.textColor = NSColor.whiteColor()
        self.headerLabel.alphaValue = 0.6
        self.headerLabel.font = NSFont(name: "OpenSans-Semibold", size: 40)
        self.headerLabel.sizeToFit()
        self.headerLabel.frame = NSMakeRect((self.view.frame.width - self.headerLabel.frame.width)/2, self.view.frame.height - self.headerLabel.frame.height - 25, self.headerLabel.frame.width, self.headerLabel.frame.height)
        self.view.addSubview(self.headerLabel)

        self.editableTextField.frame = NSMakeRect(0, 0, 0, 0)
        self.editableTextField.bordered = false
        self.editableTextField.bezeled = false
        self.editableTextField.drawsBackground = false
        self.editableTextField.stringValue = "5"
        self.editableTextField.textColor = NSColor.whiteColor()
        self.editableTextField.alphaValue = 0.6
        self.editableTextField.font = NSFont(name: "OpenSans", size: 225)
        self.editableTextField.focusRingType = NSFocusRingType.None
        self.editableTextField.alignment = NSTextAlignment.RightTextAlignment
        self.editableTextField.sizeToFit()
        self.editableTextField.frame = NSMakeRect((self.view.frame.width - self.editableTextField.frame.width*4.75)/2, (self.view.frame.height - self.editableTextField.frame.height)/2 + 75, self.editableTextField.frame.width * 3, self.editableTextField.frame.height)
        self.view.addSubview(self.editableTextField)

        self.minutesLabel.frame = NSMakeRect(0, 0, 0, 0)
        self.minutesLabel.bordered = false
        self.minutesLabel.bezeled = false
        self.minutesLabel.editable = false
        self.minutesLabel.selectable = false
        self.minutesLabel.drawsBackground = false
        self.minutesLabel.stringValue = "min"
        self.minutesLabel.textColor = NSColor.whiteColor()
        self.minutesLabel.alphaValue = 0.6
        self.minutesLabel.font = NSFont(name: "OpenSans", size: 30)
        self.minutesLabel.sizeToFit()
        self.minutesLabel.frame = NSMakeRect(self.editableTextField.frame.origin.x + self.editableTextField.frame.width + 15, self.editableTextField.frame.origin.y + 55, self.minutesLabel.frame.width, self.minutesLabel.frame.height)
        self.view.addSubview(self.minutesLabel)

        self.workAgainButton.frame = NSMakeRect((self.view.frame.width / 2) - 290, self.editableTextField.frame.origin.y - 125, 265, 55)
        self.workAgainButton.bordered = false
        self.workAgainButton.image = NSImage(named: "background-break-button")
        self.workAgainButton.attributedTitle = TextAttributter.attributedStringForButtons("WORK AGAIN", font: "AvenirNext-DemiBold", color: NSColor(calibratedHue:0, saturation:0, brightness:0.22, alpha:1))
        self.workAgainButton.setButtonType(NSButtonType.MomentaryChangeButton)
        self.workAgainButton.alphaValue = 0.8
        self.workAgainButton.target = self
        self.workAgainButton.action = "onWorkAgainButtonPressed"
        self.view.addSubview(self.workAgainButton)

        self.startBreakButton.frame = NSMakeRect((self.view.frame.width / 2) + 25, self.editableTextField.frame.origin.y - 125, 265, 55)
        self.startBreakButton.bordered = false
        self.startBreakButton.image = NSImage(named: "background-break-button")
        self.startBreakButton.attributedTitle = TextAttributter.attributedStringForButtons("START BREAK", font: "AvenirNext-DemiBold", color: NSColor(calibratedHue:0, saturation:0, brightness:0.22, alpha:1))
        self.startBreakButton.setButtonType(NSButtonType.MomentaryChangeButton)
        self.startBreakButton.alphaValue = 0.8
        self.startBreakButton.target = self
        self.startBreakButton.action = "onStartBreakButtonPressed"
        self.view.addSubview(self.startBreakButton)

        self.closeWindowButton.frame = NSMakeRect(17, self.view.frame.height - 34, 17, 17)
        self.closeWindowButton.bordered = false
        self.closeWindowButton.image = NSImage(named: "close-break-button")
        self.closeWindowButton.setButtonType(NSButtonType.MomentaryChangeButton)
        self.startBreakButton.alphaValue = 0.8
        self.closeWindowButton.target = self
        self.closeWindowButton.action = "onCloseButtonPressed"
        self.view.addSubview(self.closeWindowButton)

        self.quoteLabel.frame = NSMakeRect(0, 0, 0, 0)
        self.quoteLabel.bordered = false
        self.quoteLabel.bezeled = false
        self.quoteLabel.editable = false
        self.quoteLabel.selectable = false
        self.quoteLabel.drawsBackground = false
        self.quoteLabel.stringValue = "Stay hungry, stay foolish..."
        self.quoteLabel.textColor = NSColor.whiteColor()
        self.quoteLabel.alphaValue = 0.6
        self.quoteLabel.font = NSFont(name: "OpenSansLight-Italic", size: 18)
        self.quoteLabel.sizeToFit()
        self.quoteLabel.frame = NSMakeRect((self.view.frame.width - self.quoteLabel.frame.width)/2, (self.workAgainButton.frame.origin.y - self.quoteLabel.frame.height)/2 + self.quoteLabel.frame.height/2, self.quoteLabel.frame.width, self.quoteLabel.frame.height)
        self.view.addSubview(self.quoteLabel)

        self.authorLabel.frame = NSMakeRect(0, 0, 0, 0)
        self.authorLabel.bordered = false
        self.authorLabel.bezeled = false
        self.authorLabel.editable = false
        self.authorLabel.selectable = false
        self.authorLabel.drawsBackground = false
        self.authorLabel.stringValue = "Steve Jobs"
        self.authorLabel.textColor = NSColor.whiteColor()
        self.authorLabel.alphaValue = 0.6
        self.authorLabel.font = NSFont(name: "OpenSansLight-Italic", size: 16)
        self.authorLabel.sizeToFit()
        self.authorLabel.frame = NSMakeRect(self.quoteLabel.frame.origin.x + self.quoteLabel.frame.width - self.authorLabel.frame.width, self.quoteLabel.frame.origin.y - self.authorLabel.frame.height, self.authorLabel.frame.width, self.authorLabel.frame.height)
        self.view.addSubview(self.authorLabel)

        self.initialFrameMinutes = self.editableTextField.frame
    }

    // MARK: Timer methods

    func onLabelShouldChange() {
        if self.editableTextField.stringValue == "00:00" {
            self.breakTimer.invalidate()
        } else {
            self.editableTextField.stringValue = DateFormatting.getStringFormattedWithDate(self.editableTextField)
        }
    }

    // MARK: Action handlers

    func onWorkAgainButtonPressed() {
        self.view.window?.close()
    }

    func onStartBreakButtonPressed() {
        self.minutesLabel.hidden = true
        self.view.window?.makeFirstResponder(nil)
        self.editableTextField.editable = false
        self.editableTextField.selectable = false

        let numberFormatter = NSNumberFormatter()
        let numberMinutes = numberFormatter.numberFromString(self.editableTextField.stringValue)

        if numberMinutes?.integerValue > 60 {
            self.editableTextField.stringValue = "59:59"
        } else if numberMinutes?.integerValue < 1 {
            let numberSeconds = Int(numberMinutes!.floatValue * 60)

            if numberSeconds < 10 {
                self.editableTextField.stringValue = "00:0\(numberSeconds)"
            } else {
                self.editableTextField.stringValue = "00:\(numberSeconds)"
            }
        } else {
            if numberMinutes?.integerValue < 10 {
                self.editableTextField.stringValue = "0\(numberMinutes!.integerValue):00"
            } else {
                self.editableTextField.stringValue = "\(numberMinutes!.integerValue):00"
            }
        }

        self.editableTextField.sizeToFit()
        self.editableTextField.frame = NSMakeRect((self.view.frame.width - self.editableTextField.frame.width)/2, self.initialFrameMinutes.origin.y, self.editableTextField.frame.width, self.editableTextField.frame.height)

        self.breakTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onLabelShouldChange", userInfo: nil, repeats: true)
    }

    func onCloseButtonPressed() {
        self.view.window?.close()
    }

    // MARK: Mouse events

    override func mouseDown(theEvent: NSEvent) {
        self.view.window?.makeFirstResponder(nil)
    }
}
