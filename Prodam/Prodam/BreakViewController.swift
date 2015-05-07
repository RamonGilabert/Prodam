import Cocoa

class BreakViewController: NSViewController {

    override func loadView() {
        self.view = NSView()
        self.view.frame = NSMakeRect(0, 0, 800, 600)
        
        let button = NSButton(frame: NSMakeRect(0, 0, 200, 200))
        button.title = "Sup"
        self.view.addSubview(button)
    }
}
