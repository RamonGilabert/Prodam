import Cocoa

class PopoverManager: NSObject {

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    let popoverController = PopoverController()
    let popoverView = PopoverView()
    var popoverIsActive = false

    // MARK: View lifecycle

    override init() {
        super.init()

        let iconMenu = NSImage(named: "menu-logo")
        iconMenu?.setTemplate(true)

        self.popoverView.frame = NSMakeRect(0, 0, NSStatusBar.systemStatusBar().thickness + 5, NSStatusBar.systemStatusBar().thickness)
        let imageView = NSImageView(frame: NSMakeRect(0, 0, NSStatusBar.systemStatusBar().thickness, NSStatusBar.systemStatusBar().thickness))
        imageView.image = iconMenu
        self.popoverView.addSubview(imageView)

        self.statusItem.view = self.popoverView
    }

    // MARK: Icon clicked handlers
}
