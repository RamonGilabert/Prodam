import Cocoa

class BreakWindowController: NSWindowController {

    override func loadWindow() {
        self.window = BreakWindow(contentRect: NSMakeRect(0, 0, 1400, 800), styleMask: NSBorderlessWindowMask | NSTexturedBackgroundWindowMask, backing: NSBackingStoreType.Buffered, defer: false)
        self.window?.backgroundColor = NSColor.redColor()
        self.window?.center()
        self.window?.makeKeyAndOrderFront(true)
        self.window?.display()
    }

}
