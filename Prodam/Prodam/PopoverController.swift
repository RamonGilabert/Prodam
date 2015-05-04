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
        let buttonCell = self.addTaskButton.cell() as! NSButtonCell
        buttonCell.backgroundColor = NSColor(calibratedHue:0.36, saturation:0.49, brightness:0.76, alpha:1)
        let mutableStringAddTaskButton = NSMutableAttributedString(string: "START WORKING")
        mutableStringAddTaskButton.addAttribute(NSForegroundColorAttributeName, value: NSColor.whiteColor(), range: NSMakeRange(0, mutableStringAddTaskButton.length))
        mutableStringAddTaskButton.addAttribute(NSFontAttributeName, value: NSFont(name: "AvenirNext-DemiBold", size: 20)!, range: NSMakeRange(0, mutableStringAddTaskButton.length))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.CenterTextAlignment
        mutableStringAddTaskButton.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, mutableStringAddTaskButton.length))
        self.addTaskButton.attributedTitle = mutableStringAddTaskButton
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