import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    var mainWindowController: MainWindowController?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let iconMenu = NSImage(named: "menu-logo")
        iconMenu?.setTemplate(true)

        self.statusItem.image = iconMenu
    }
}

