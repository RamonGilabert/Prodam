import Cocoa

class BreakWindowController: NSWindowController {

    let breakViewController = BreakViewController()
    var popoverManager: PopoverManager?

    // MARK: View lifecycle

    override func loadWindow() {
        self.window = BreakWindow(contentRect: self.breakViewController.view.frame, styleMask: NSBorderlessWindowMask, backing: NSBackingStoreType.Buffered, defer: false)
        self.window?.contentView = RoundedCornerView(frame: self.breakViewController.view.frame)
        self.window?.center()
        self.window?.animationBehavior = NSWindowAnimationBehavior.AlertPanel
        self.window?.display()
        self.window?.makeKeyWindow()
        self.window?.makeMainWindow()
        NSApp.activateIgnoringOtherApps(true)
        self.window?.makeKeyAndOrderFront(true)
        self.breakViewController.popoverManager = self.popoverManager
        self.popoverManager?.breakController = self
        
        (self.window?.contentView as! RoundedCornerView).visualEffectView.addSubview(self.breakViewController.view)
    }
}
