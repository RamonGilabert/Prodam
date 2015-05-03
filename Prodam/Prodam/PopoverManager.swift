import Cocoa

class PopoverManager: NSObject {

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    let popoverController = PopoverController()
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
            self.popoverController.popover.showRelativeToRect(NSMakeRect(0, 0, 30, 30), ofView: self.popoverController.view, preferredEdge: NSMinYEdge)
        } else if self.popoverIsActive == true {
            self.popoverIsActive == false
        }
    }
}
