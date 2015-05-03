import Cocoa

class PopoverController: NSObject {

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    var popoverIsActive = false

    // MARK: View lifecycle

    override init() {
        super.init()

        let iconMenu = NSImage(named: "menu-logo")
        iconMenu?.setTemplate(true)

        self.statusItem.image = iconMenu
        self.statusItem.target = self
        self.statusItem.action = "onStatusItemClicked"
    }

    // MARK: Action handlers

    func onStatusItemClicked() {
        if self.popoverIsActive == false {
            self.popoverIsActive == true
        } else if self.popoverIsActive == true {
            self.popoverIsActive == false
        }
    }

}
