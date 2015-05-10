import Cocoa

class PreferencesWindowController: NSWindowController {

    override func loadWindow() {
        self.window = BreakWindow(contentRect: NSMakeRect(0, 0, 400, 500), styleMask: NSBorderlessWindowMask, backing: NSBackingStoreType.Buffered, defer: false)
        self.window?.contentView = RoundedCornerView(frame: self.window!.frame)
        self.window?.center()
        self.window?.backgroundColor = NSColor.whiteColor()
        self.window?.animationBehavior = NSWindowAnimationBehavior.DocumentWindow
        self.window?.display()
        self.window?.makeKeyWindow()
        NSApp.activateIgnoringOtherApps(true)
        self.window?.makeKeyAndOrderFront(true)
    }
}
