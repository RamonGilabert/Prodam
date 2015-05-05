import Cocoa

class PopoverWindowController: NSWindowController, Resignator {

    let popoverController = PopoverController()
    var popoverManager: PopoverManager?
    var popover = NSPopover()

    override func loadWindow() {
        self.window = NSWindow_Popover(contentRect: NSMakeRect(0, 0, 0, 0), styleMask: 1, backing: NSBackingStoreType.Buffered, defer: false)
        self.popoverController.loadView()
        self.popover = self.popoverController.popover
        self.popoverController.delegate = self

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "windowNeedsToClose", name: NSWindowDidResignMainNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "windowNeedsToClose", name: NSWindowDidResignKeyNotification, object: nil)
    }

    // MARK: Delegate methods

    func makeResponder(textField: NSTextField) {
        self.window?.makeFirstResponder(nil)
        self.window?.makeFirstResponder(textField)
    }

    func resignAllResponders() {
        self.window?.makeFirstResponder(nil)
    }

    // MARK: Notification handlers

    func windowNeedsToClose() {
        self.popoverManager!.popoverIsActive = false
        self.window?.makeFirstResponder(nil)
        self.popover.close()
    }
}
