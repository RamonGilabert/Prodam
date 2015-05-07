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
    }
}
