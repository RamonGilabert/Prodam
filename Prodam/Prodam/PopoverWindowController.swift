import Cocoa

class PopoverWindowController: NSWindowController {

    let popoverController = PopoverController()
    var popover = NSPopover()

    override func loadWindow() {
        self.popoverController.loadView()
        self.window = NSWindow_Popover(contentRect: NSMakeRect(0, 0, 0, 0), styleMask: 1, backing: NSBackingStoreType.Buffered, defer: false)
        self.popover = self.popoverController.popover

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "windowNeedsToClose", name: NSWindowDidResignMainNotification, object: nil)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "windowNeedsToClose", name: NSWindowDidBecomeMainNotification, object: nil)
    }

    // MARK: Notification handlers

    func windowNeedsToClose() {
        self.popover.close()
    }
}
