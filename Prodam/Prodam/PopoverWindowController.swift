import Cocoa

class PopoverWindowController: NSWindowController {

    let popoverController = PopoverController()
    var popover = NSPopover()

    override func loadWindow() {
        self.popoverController.loadView()
        self.window = NSWindow_Popover(contentRect: NSMakeRect(0, 0, 100, 100), styleMask: 1, backing: NSBackingStoreType.Buffered, defer: false)
        self.popover = self.popoverController.popover
        self.window?.alphaValue = 0

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "windowNeedsToClose", name: NSWindowDidResignMainNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "windowNeedsToClose", name: NSWindowDidResignKeyNotification, object: nil)
    }

    // MARK: Notification handlers

    func windowNeedsToClose() {
        println("Sup")
        self.popover.close()
    }
}
