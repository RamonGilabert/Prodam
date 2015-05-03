import Cocoa

class PopoverManager: NSObject {

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    let popoverController = PopoverController()
    let popoverView = NSView()
    var popoverIsActive = false

    // MARK: View lifecycle

    override init() {
        super.init()

        let iconMenu = NSImage(named: "menu-logo")
        iconMenu?.setTemplate(true)

        let view = NSView(frame: NSMakeRect(0, 0, NSStatusBar.systemStatusBar().thickness, NSStatusBar.systemStatusBar().thickness))
        let imageView = NSImageView(frame: NSMakeRect(0, 0, NSStatusBar.systemStatusBar().thickness, NSStatusBar.systemStatusBar().thickness))
        imageView.image = iconMenu
        view.addSubview(imageView)

        self.statusItem.view = view
        self.statusItem.target = self
        self.statusItem.action = "onStatusItemClicked"
    }

    // MARK: Action handlers

    func onStatusItemClicked() {
        if self.popoverIsActive == false {
            self.popoverIsActive == true
            let view = NSView(frame: NSMakeRect(0, 0, 200, 200))
            self.popoverController.popover.showRelativeToRect(NSMakeRect(0, 0, 30, 30), ofView: view, preferredEdge: NSMinYEdge)
        } else if self.popoverIsActive == true {
            self.popoverIsActive == false
        }
    }
}
