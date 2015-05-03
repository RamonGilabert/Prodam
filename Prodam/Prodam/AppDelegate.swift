import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainPopoverController: PopoverManager?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        self.mainPopoverController = PopoverManager()
    }
}

