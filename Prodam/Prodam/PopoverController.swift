import Cocoa

class PopoverController: NSViewController {

    let popover = NSPopover()

    override func loadView() {
        self.view = NSView()
        self.view.frame = NSMakeRect(0, 0, 200, 200)
        println(self.view.window)
        self.popover.contentViewController = self
        let backgroundColor = NSColor.redColor()
        backgroundColor.set()
        NSBezierPath.fillRect(self.view.frame)
    }
}