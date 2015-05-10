import Cocoa

class PopoverWindowController: NSWindowController, Resignator, PopoverManagerDelegate {

    let popoverController = PopoverController()
    var popoverManager: PopoverManager?
    var popover = NSPopover()

    // MARK: View lifecycle

    override func loadWindow() {
        self.window = NSWindow_Popover(contentRect: NSMakeRect(0, 0, 0, 0), styleMask: 1, backing: NSBackingStoreType.Buffered, defer: false)
        self.popoverController.loadView()
        self.popover = self.popoverController.popover
        self.popoverController.delegate = self
        self.popoverManager?.delegate = self
        self.popoverController.breakWindowController = BreakWindowController()
        self.popoverController.breakWindowController?.breakViewController.popoverManager?.delegate = self.popoverManager

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "windowNeedsToClose", name: NSWindowDidResignMainNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "windowNeedsToClose", name: NSWindowDidResignKeyNotification, object: nil)
    }

    // MARK: Delegate methods

    func makeResponder(textField: NSTextField) {
        self.window?.makeFirstResponder(nil)
        self.window?.makeFirstResponder(textField)
    }

    // MARK: Notification handlers

    func windowNeedsToClose() {
        self.popoverManager!.popoverIsActive = false
        self.window?.makeFirstResponder(nil)
        self.popover.close()
    }
}
