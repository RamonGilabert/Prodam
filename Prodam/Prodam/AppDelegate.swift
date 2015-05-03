import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainPopoverController: PopoverController?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        self.mainPopoverController = PopoverController()
    }
}

