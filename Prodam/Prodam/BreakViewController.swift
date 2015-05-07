import Cocoa

class BreakViewController: NSViewController {

    var headerLabel = NSTextField()
    var minutesLabel = NSTextField()
    var editableTextField = NSTextField()
    var realTextField = NSTextField()
    var sentenceLabel = NSTextField()
    var authorLabel = NSTextField()
    var workAgainButton = NSButton()
    var startBreakButton = NSButton()
    var closeWindowButton = NSButton()

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
        self.editableTextField.font = NSFont(name: "OpenSans", size: 200)
        self.editableTextField.focusRingType = NSFocusRingType.None
        self.editableTextField.alignment = NSTextAlignment.RightTextAlignment
        self.editableTextField.sizeToFit()
        self.editableTextField.frame = NSMakeRect((self.view.frame.width - self.editableTextField.frame.width*3)/2, (self.view.frame.height - self.editableTextField.frame.height)/2 + 100, self.editableTextField.frame.width * 2, self.editableTextField.frame.height)
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

        self.workAgainButton.frame = NSMakeRect(100, 100, 265, 55)
        self.workAgainButton.bordered = false
        self.workAgainButton.image = NSImage(named: "background-break-button")
        self.workAgainButton.title = TextAttributter.attributedStringForButtons("WORK AGAIN", font: "OpenSans-Semibold", color: NSColor(calibratedHue:0, saturation:0, brightness:0.22, alpha:1))
        self.view.addSubview(self.workAgainButton)

    }
}
