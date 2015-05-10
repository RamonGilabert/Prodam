import Cocoa

class PreferencesWindowController: NSWindowController {

    var popoverManager: PopoverManager?
    var popoverController: PopoverController?

    override func loadWindow() {
        self.window = BreakWindow(contentRect: NSMakeRect(0, 0, 500, 360), styleMask: NSBorderlessWindowMask, backing: NSBackingStoreType.Buffered, defer: false)
        self.window?.contentView = RoundedPreferencesView(frame: self.window!.frame)
        self.window?.center()
        self.window?.animationBehavior = NSWindowAnimationBehavior.DocumentWindow
        self.window?.makeKeyAndOrderFront(true)
        self.popoverController?.preferencesWindowController = self
    }
}
