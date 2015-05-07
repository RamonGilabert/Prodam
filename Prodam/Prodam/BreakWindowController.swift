import Cocoa

class BreakWindowController: NSWindowController {

    let breakViewController = BreakViewController()

    override func loadWindow() {
        self.window = BreakWindow(contentRect: NSMakeRect(0, 0, 800, 600), styleMask: NSBorderlessWindowMask, backing: NSBackingStoreType.Buffered, defer: false)
        self.window?.contentView = RoundedCornerView(frame: self.window!.frame)
        self.window?.center()
        self.window?.makeKeyAndOrderFront(true)
        self.window?.display()
        self.window?.becomeKeyWindow()
        self.window?.becomeMainWindow()

        self.window?.contentView.addSubview(self.breakViewController.view)
    }
}
