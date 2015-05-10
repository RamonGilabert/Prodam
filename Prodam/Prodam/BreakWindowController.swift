import Cocoa

class BreakWindowController: NSWindowController {

    let breakViewController = BreakViewController()

    // MARK: View lifecycle

    override func loadWindow() {
        self.window = BreakWindow(contentRect: self.breakViewController.view.frame, styleMask: NSBorderlessWindowMask, backing: NSBackingStoreType.Buffered, defer: false)
        self.window?.contentView = RoundedCornerView(frame: self.breakViewController.view.frame)
        self.window?.center()
        self.window?.animationBehavior = NSWindowAnimationBehavior.AlertPanel
        self.window?.display()
        self.window?.makeKeyWindow()
        self.window?.makeKeyAndOrderFront(true)

        (self.window?.contentView as! RoundedCornerView).visualEffectView.addSubview(self.breakViewController.view)
    }
}
