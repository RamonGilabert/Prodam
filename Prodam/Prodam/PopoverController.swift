import Cocoa

class PopoverController: NSViewController {

    let popover = NSPopover()

    override func loadView() {
        self.view = NSView()
        self.view.frame = NSMakeRect(0, 0, 200, 200)
        self.popover.contentViewController = self
    }
}