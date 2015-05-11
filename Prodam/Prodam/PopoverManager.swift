import Cocoa

@objc protocol PopoverManagerDelegate {
    optional func openThatPopover()
    optional func closeThatPopover()
    optional func configureThatView()
    optional func configureThatMenu()
}

class PopoverManager: NSObject, ViewClicked, PopoverManagerDelegate {

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    let popoverView = PopoverView()
    let menuPopover = NSMenu()
    let iconMenu = NSImage(named: "menu-logo")
    let preferencesWindowController = PreferencesWindowController()
    var popoverController = PopoverWindowController()
    var breakController: BreakWindowController?
    var popoverIsActive = false
    var delegate: PopoverManagerDelegate?

    // MARK: View lifecycle

    override init() {
        super.init()

        self.iconMenu?.setTemplate(true)

        self.popoverView.frame = NSMakeRect(0, 0, NSStatusBar.systemStatusBar().thickness + 2, NSStatusBar.systemStatusBar().thickness)
        self.popoverView.delegate = self
        let imageView = NSImageView(frame: NSMakeRect(0, 0, NSStatusBar.systemStatusBar().thickness, NSStatusBar.systemStatusBar().thickness))
        imageView.image = self.iconMenu
        self.popoverView.addSubview(imageView)

        self.popoverController.popoverManager = self
        self.popoverController.loadWindow()
        self.delegate = self

        let firstItemMenu = NSMenuItem(title: "Get back to work", action: "onGetBackToWorkButtonPressed", keyEquivalent: "first")
        let secondItemMenu = NSMenuItem(title: "Preferences", action: "onPreferencesButtonPressed", keyEquivalent: "second")
        let thirdItemMenu = NSMenuItem(title: "Quit", action: "onQuitMenuButtonPressed", keyEquivalent: "third")
        firstItemMenu.target = self
        secondItemMenu.target = self
        thirdItemMenu.target = self

        self.menuPopover.addItem(firstItemMenu)
        self.menuPopover.addItem(NSMenuItem.separatorItem())
        self.menuPopover.addItem(secondItemMenu)
        self.menuPopover.addItem(thirdItemMenu)

        self.statusItem.view = self.popoverView
        openThatPopover()

        self.popoverController.popoverController.preferencesWindowController = self.preferencesWindowController
    }

    // MARK: Icon clicked handlers

    func buttonClicked() {
        if self.popoverIsActive == false {
            openThatPopover()
        } else if self.popoverIsActive == true {
            closeThatPopover()
        }
    }

    // MARK: Action methods

    func onGetBackToWorkButtonPressed() {
        self.breakController?.window?.close()
        self.preferencesWindowController.window?.close()
        configureThatView()
        openThatPopover()
    }

    func onPreferencesButtonPressed() {
        configureThatMenu()
        self.preferencesWindowController.popoverManager = self
        self.preferencesWindowController.loadWindow()
    }

    func onQuitMenuButtonPressed() {
        NSApplication.sharedApplication().terminate(self)
    }

    // MARK: Delegate methods

    func openThatPopover() {
        self.popoverIsActive = true
        self.popoverController.popover.showRelativeToRect(NSMakeRect(self.popoverView.frame.origin.x, self.popoverView.frame.origin.y - 5, self.popoverView.frame.width, self.popoverView.frame.height), ofView: self.popoverView, preferredEdge: NSMaxYEdge)
        NSApp.activateIgnoringOtherApps(true)
        self.popoverController.window?.makeMainWindow()
        self.popoverController.popoverController.view.window?.makeFirstResponder(self.popoverController.popoverController.editableTimerTextField)
    }

    func closeThatPopover() {
        self.popoverIsActive = false
        self.popoverController.window?.resignMainWindow()
        self.popoverController.window?.resignKeyWindow()
        self.popoverController.window?.makeFirstResponder(nil)
        self.popoverController.popover.close()
    }

    func configureThatView() {
        self.statusItem.view = self.popoverView
        self.statusItem.menu = nil
        self.statusItem.image = nil
    }

    func configureThatMenu() {
        self.statusItem.menu = self.menuPopover
        self.statusItem.view = nil
        self.statusItem.image = self.iconMenu


    }
}
