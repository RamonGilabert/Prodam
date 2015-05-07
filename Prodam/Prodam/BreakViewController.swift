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
        self.view.frame = NSMakeRect(0, 0, 800, 600)
        
        self.headerLabel.frame = NSMakeRect(0, 0, 0, 0)
        self.headerLabel.bordered = false
        self.headerLabel.bezeled = false
        self.headerLabel.editable = false
        self.headerLabel.selectable = false
        self.headerLabel.stringValue = "TAKING A BREAK"
        self.headerLabel.font = NSFont(name: "", size: 50)
        self.headerLabel.sizeToFit()
        self.headerLabel.appearance = NSAppearance(named: NSAppearanceNameVibrantLight)
        self.view.addSubview(self.headerLabel)

    }
}
