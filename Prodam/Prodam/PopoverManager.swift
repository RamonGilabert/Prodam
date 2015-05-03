import Cocoa

class PopoverManager: NSObject, ViewClicked {

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    var popoverController = PopoverWindowController()
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

        self.popoverController.loadWindow()

        self.statusItem.image = iconMenu
        self.statusItem.target = self
        self.statusItem.action = "onStatusItemClicked"
    }

    // MARK: Icon clicked handlers

    func onStatusItemClicked() {
        if self.popoverIsActive == false {
            self.popoverIsActive = true
            self.popoverController.popover.showRelativeToRect(NSMakeRect(self.popoverView.frame.origin.x, self.popoverView.frame.origin.y - 5, self.popoverView.frame.width, self.popoverView.frame.height), ofView: self.popoverView, preferredEdge: NSMaxYEdge)
            self.popoverController.window?.makeMainWindow()
            println(self.popoverController.window?.mainWindow)
        } else if self.popoverIsActive == true {
            self.popoverIsActive = false
            self.popoverController.popover.close()
            self.popoverController.window?.resignMainWindow()
            println(self.popoverController.window?.mainWindow)
        }
    }

    func buttonClicked() {
        if self.popoverIsActive == false {
            self.popoverIsActive = true
            self.popoverController.popover.showRelativeToRect(NSMakeRect(self.popoverView.frame.origin.x, self.popoverView.frame.origin.y - 5, self.popoverView.frame.width, self.popoverView.frame.height), ofView: self.popoverView, preferredEdge: NSMaxYEdge)
            self.popoverController.window?.makeMainWindow()
            println(self.popoverController.window?.mainWindow)
        } else if self.popoverIsActive == true {
            self.popoverIsActive = false
            self.popoverController.popover.close()
            self.popoverController.window?.resignMainWindow()
            println(self.popoverController.window?.mainWindow)
        }
    }
}
