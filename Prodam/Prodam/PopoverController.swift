import Cocoa

class PopoverController: NSViewController, NSPopoverDelegate {

    let popover = NSPopover()

    override func loadView() {
        self.view = NSView()
        self.view.frame = NSMakeRect(0, 0, 275, 400)
        
        self.popover.contentViewController = self
        self.popover.appearance = NSAppearance(named: NSAppearanceNameVibrantLight)
        self.popover.delegate = self

        let button = NSButton(frame: NSMakeRect(0, 0, 100, 100))
        button.title = "Sup"
        self.view.addSubview(button)
    }
}