import Cocoa

class BreakWindowController: NSWindowController {

    let popoverController = BreakController()
    var popoverManager: PopoverManager?
    var popover = NSPopover()

    override func loadWindow() {
        self.window = NSWindow(contentRect: NSMakeRect(0, 0, 0, 0), styleMask: 1, backing: NSBackingStoreType.Buffered, defer: false)
    }

}
