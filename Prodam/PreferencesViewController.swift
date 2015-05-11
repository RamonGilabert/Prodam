import Cocoa

class PreferencesViewController: NSViewController {

    let viewModel = ViewModel()

    override func loadView() {
        self.view = NSView(frame: NSMakeRect(0, 0, 500, 360))

        let titlePreferences = NSTextField()
        titlePreferences.bordered = false
        titlePreferences.bezeled = false
        titlePreferences.editable = false
        titlePreferences.selectable = false
        titlePreferences.drawsBackground = false
        titlePreferences.stringValue = "Preferences"
        titlePreferences.font = NSFont(name: "Helvetica Neue", size: 18)
        titlePreferences.alignment = NSTextAlignment.CenterTextAlignment
        titlePreferences.sizeToFit()
        titlePreferences.frame = NSMakeRect((self.view.frame.width - titlePreferences.frame.width)/2, self.view.frame.height - titlePreferences.frame.height - 11, titlePreferences.frame.width, titlePreferences.frame.height)
        self.view.addSubview(titlePreferences)

        let buttonClosePreferences = NSButton(frame: NSMakeRect(12, self.view.frame.height - 28, 16, 16))
        buttonClosePreferences.bordered = false
        buttonClosePreferences.setButtonType(NSButtonType.MomentaryChangeButton)
        buttonClosePreferences.image = NSImage(named: "button-close-preferences")
        buttonClosePreferences.target = self
        buttonClosePreferences.action = "onClosePreferencesButtonPressed"
        self.view.addSubview(buttonClosePreferences)

        let buttonQuitLogin = NSButton(frame: NSMakeRect(self.view.frame.width - 29, self.view.frame.height - 30, 17, 18))
        buttonQuitLogin.bordered = false
        buttonQuitLogin.setButtonType(NSButtonType.MomentaryChangeButton)
        buttonQuitLogin.image = NSImage(named: "button-quit-preferences")
        buttonQuitLogin.target = self
        buttonQuitLogin.action = "onQuitAppButtonPressed"
        self.view.addSubview(buttonQuitLogin)

        let topSeparator = NSView(frame: NSMakeRect(0, self.view.frame.height - 45, self.view.frame.width, 1))
        topSeparator.wantsLayer = true
        topSeparator.layer?.backgroundColor = NSColor.lightGrayColor().CGColor
        self.view.addSubview(topSeparator)

        let labelGeneral = NSTextField()

        let labelLaunchLogin = NSTextField()

        let labelSoundWhenDone = NSTextField()

        let bottomSeparator = NSView()

        let labelAbout = NSTextField()

        let labelName = NSTextField()

        let buttonTwitter = NSButton()

        let buttonWebsite = NSButton()

        let buttonEmail = NSButton()

    }

    // MARK: Action handlers

    func onClosePreferencesButtonPressed() {

    }

    func onQuitAppButtonPressed() {

    }
}
