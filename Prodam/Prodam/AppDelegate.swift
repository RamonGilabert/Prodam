import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let userDefaults = NSUserDefaults.standardUserDefaults()
    var mainPopoverController: PopoverManager?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        if self.userDefaults.valueForKey("isFirstTime") == nil || self.userDefaults.boolForKey("isFirstTime") == true {
            self.userDefaults.setBool(false, forKey: "isFirstTime")
            self.userDefaults.setBool(false, forKey: "startLaunch")
            self.userDefaults.setBool(true, forKey: "soundDone")
        }

        self.mainPopoverController = PopoverManager()
    }
}

