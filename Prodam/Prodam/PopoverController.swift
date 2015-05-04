import Cocoa

class PopoverController: NSViewController, NSPopoverDelegate {

    let popover = NSPopover()
    let addTaskButton = NSButton()
    let doneTaskButton = NSButton()
    let pauseTaskButton = NSButton()
    let taskButton = NSButton()
    let settingsButton = NSButton()
    let taskTextField = NSTextField()
    let timerTextField = NSTextField()

    override func loadView() {
        self.view = NSView()
        self.view.frame = NSMakeRect(0, 0, Constant.Window.Width, Constant.Window.Height)
        
        self.popover.contentViewController = self
        self.popover.appearance = NSAppearance(named: NSAppearanceNameVibrantLight)
        self.popover.delegate = self
    }
}