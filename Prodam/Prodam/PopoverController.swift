import Cocoa

class PopoverController: NSViewController {

    let popover = NSPopover()

    override func loadView() {
        self.view = NSView()
        self.view.frame = NSMakeRect(0, 0, 600, 600)
        self.popover.contentViewController = self

        let backgroundColor = NSColor.whiteColor()
        backgroundColor.set()
        NSBezierPath.fillRect(self.view.frame)
    }
}