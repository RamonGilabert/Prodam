import Cocoa

class PopoverWindowController: NSWindowController {

    let popover = NSPopover()

    override func loadWindow() {
        self.window = NSWindow_Popover(contentRect: NSMakeRect(0, 0, 0, 0), styleMask: 1, backing: NSBackingStoreType.Buffered, defer: false)
        self.popover.contentViewController = PopoverController()
        self.popover.appearance = NSAppearance(named: NSAppearanceNameVibrantLight)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "windowNeedsToClose", name: NSWindowDidResignMainNotification, object: nil)
    }

    // MARK: Notification handlers

    func windowNeedsToClose() {
        self.popover.close()
    }
}
