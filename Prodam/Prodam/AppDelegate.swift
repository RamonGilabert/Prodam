import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainPopoverController: PopoverManager?
    let breakWindowController = BreakWindowController()

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        self.mainPopoverController = PopoverManager()
        //self.breakWindowController.loadWindow()
    }
}

