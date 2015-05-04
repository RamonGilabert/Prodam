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

        addAllSubviewProperties()
        
        self.popover.contentViewController = self
        self.popover.appearance = NSAppearance(named: NSAppearanceNameVibrantLight)
        self.popover.delegate = self

        self.addTaskButton.frame = NSMakeRect(Constant.MainWindowLayout.MinimumPaddingButton, Constant.MainWindowLayout.MinimumPaddingButton, Constant.Window.Width - (2 * Constant.MainWindowLayout.MinimumPaddingButton), Constant.MainWindowLayout.HeightOfButton)
    }

    // MARK: Helper methods

    func addAllSubviewProperties() {
        self.view.addSubview(self.addTaskButton)
        self.view.addSubview(self.doneTaskButton)
        self.view.addSubview(self.pauseTaskButton)
        self.view.addSubview(self.taskButton)
        self.view.addSubview(self.settingsButton)
        self.view.addSubview(self.taskTextField)
        self.view.addSubview(self.timerTextField)
    }
}