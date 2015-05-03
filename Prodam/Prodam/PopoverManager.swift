import Cocoa

class PopoverManager: NSObject, ViewClicked {

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    let popoverController = PopoverController()
    let popoverView = PopoverView()
    var popoverIsActive = false

    // MARK: View lifecycle

    override init() {
        super.init()

        let iconMenu = NSImage(named: "menu-logo")
        iconMenu?.setTemplate(true)

        self.popoverView.frame = NSMakeRect(0, 0, NSStatusBar.systemStatusBar().thickness + 3, NSStatusBar.systemStatusBar().thickness)
        self.popoverView.delegate = self
        let imageView = NSImageView(frame: NSMakeRect(0, 0, NSStatusBar.systemStatusBar().thickness, NSStatusBar.systemStatusBar().thickness))
        imageView.image = iconMenu
        self.popoverView.addSubview(imageView)

        self.statusItem.view = self.popoverView
    }

    // MARK: Icon clicked handlers

    func buttonClicked() {
        if self.popoverIsActive == false {
            self.popoverIsActive = true
            self.popoverController.popover.showRelativeToRect(self.popoverView.frame, ofView: self.popoverView, preferredEdge: NSMinYEdge)
        } else if self.popoverIsActive == true {
            self.popoverIsActive = false
            self.popoverController.popover.performClose(self)
        }
    }
}
