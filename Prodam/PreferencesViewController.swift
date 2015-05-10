import Cocoa

class PreferencesViewController: NSViewController {

    let label = NSTextField()

    override func loadView() {
        self.view = NSView(frame: NSMakeRect(0, 0, 500, 360))

        self.label.frame = NSMakeRect(0, 0, 200, 200)
        self.label.stringValue = "SUUUP"

        self.view.addSubview(self.label)
    }
}
