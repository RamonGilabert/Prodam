import Cocoa

class PopoverWindowController: NSWindowController {

    let popoverController = PopoverController()
    var popoverManager: PopoverManager?
    var popover = NSPopover()

    override func loadWindow() {
        self.popoverController.loadView()
        self.window = NSWindow(contentRect: NSMakeRect(0, 0, 0, 0), styleMask: 1, backing: NSBackingStoreType.Buffered, defer: false)
        self.popover = self.popoverController.popover

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "windowNeedsToClose", name: NSWindowDidResignKeyNotification, object: nil)
    }

    // MARK: Notification handlers

    func windowNeedsToClose() {
        self.popoverManager!.popoverIsActive = false
        self.popover.close()
    }
}
