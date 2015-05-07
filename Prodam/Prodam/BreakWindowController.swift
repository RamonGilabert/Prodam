import Cocoa

class BreakWindowController: NSWindowController {

    let breakViewController = BreakViewController()

    override func loadWindow() {
        self.window = BreakWindow(contentRect: self.breakViewController.view.frame, styleMask: NSBorderlessWindowMask, backing: NSBackingStoreType.Buffered, defer: false)
        self.window?.contentView = RoundedCornerView(frame: self.window!.frame)
        self.window?.center()
        self.window?.makeKeyAndOrderFront(true)
        self.window?.display()

        (self.window?.contentView as! RoundedCornerView).visualEffectView.addSubview(self.breakViewController.view)
    }
}
