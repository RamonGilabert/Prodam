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
        
        let button = NSButton(frame: NSMakeRect(0, 0, 200, 200))
        button.title = "Sup"
        self.view.addSubview(button)
    }
}
