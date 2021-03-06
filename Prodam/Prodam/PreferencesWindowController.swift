import Cocoa

class PreferencesWindowController: NSWindowController {

    let preferencesViewController = PreferencesViewController()
    var popoverManager: PopoverManager?
    var popoverController: PopoverController?

    override func loadWindow() {
        self.window = BreakWindow(contentRect: self.preferencesViewController.view.frame, styleMask: NSBorderlessWindowMask, backing: NSBackingStoreType.Buffered, defer: false)
        self.window?.contentView = RoundedPreferencesView(frame: self.window!.frame)
        self.window?.center()
        self.window?.animationBehavior = NSWindowAnimationBehavior.DocumentWindow
        self.window?.makeKeyAndOrderFront(true)
        self.popoverController?.preferencesWindowController = self
        self.window?.hasShadow = true

        self.preferencesViewController.popoverManager = self.popoverManager

        (self.window?.contentView as! RoundedPreferencesView).visualEffectView.addSubview(self.preferencesViewController.view)
    }
}
