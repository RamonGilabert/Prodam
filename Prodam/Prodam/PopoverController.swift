import Cocoa

class PopoverController: NSViewController {

    let popover = NSPopover()

    override func loadView() {
        self.view = NSView()
        self.view.frame = NSMakeRect(0, 0, 275, 400)
        self.popover.contentViewController = self
        self.popover.appearance = NSAppearance(named: NSAppearanceNameVibrantLight)
    }
}