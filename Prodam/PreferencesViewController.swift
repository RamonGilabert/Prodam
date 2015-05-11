import Cocoa

class PreferencesViewController: NSViewController {

    let viewModel = ViewModel()
    var popoverManager: PopoverManager?

    override func loadView() {
        self.view = NSView(frame: NSMakeRect(0, 0, 460, 320))

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
        titlePreferences.frame = NSMakeRect((self.view.frame.width - titlePreferences.frame.width)/2, self.view.frame.height - titlePreferences.frame.height - 10, titlePreferences.frame.width, titlePreferences.frame.height)
        self.view.addSubview(titlePreferences)

        let buttonClosePreferences = NSButton(frame: NSMakeRect(12, self.view.frame.height - 28, 16, 16))
        buttonClosePreferences.bordered = false
        buttonClosePreferences.setButtonType(NSButtonType.MomentaryChangeButton)
        buttonClosePreferences.image = NSImage(named: "button-close-preferences")
        buttonClosePreferences.target = self
        buttonClosePreferences.action = "onClosePreferencesButtonPressed"
        self.view.addSubview(buttonClosePreferences)

        let buttonQuitLogin = NSButton(frame: NSMakeRect(self.view.frame.width - 29, self.view.frame.height - 28, 17, 18))
        buttonQuitLogin.bordered = false
        buttonQuitLogin.setButtonType(NSButtonType.MomentaryChangeButton)
        buttonQuitLogin.image = NSImage(named: "button-quit-preferences")
        buttonQuitLogin.target = self
        buttonQuitLogin.action = "onQuitAppButtonPressed"
        self.view.addSubview(buttonQuitLogin)

        let topSeparator = NSView(frame: NSMakeRect(0, self.view.frame.height - 42.5, self.view.frame.width, 1))
        topSeparator.wantsLayer = true
        topSeparator.layer?.backgroundColor = NSColor.lightGrayColor().CGColor
        self.view.addSubview(topSeparator)

        let labelGeneral = NSTextField()
        labelGeneral.bordered = false
        labelGeneral.bezeled = false
        labelGeneral.editable = false
        labelGeneral.selectable = false
        labelGeneral.drawsBackground = false
        labelGeneral.stringValue = "General"
        labelGeneral.textColor = NSColor(calibratedHue:0.67, saturation:0.06, brightness:0.49, alpha:1)
        labelGeneral.font = NSFont(name: "Helvetica Neue", size: 15)
        labelGeneral.alignment = NSTextAlignment.CenterTextAlignment
        labelGeneral.sizeToFit()
        labelGeneral.frame = NSMakeRect(100, topSeparator.frame.origin.y - 40, labelGeneral.frame.width, labelGeneral.frame.height)
        self.view.addSubview(labelGeneral)

        let labelLaunchLogin = NSTextField()
        labelLaunchLogin.bordered = false
        labelLaunchLogin.bezeled = false
        labelLaunchLogin.editable = false
        labelLaunchLogin.selectable = false
        labelLaunchLogin.drawsBackground = false
        labelLaunchLogin.stringValue = "Launch at login"
        labelLaunchLogin.textColor = NSColor(calibratedHue:1, saturation:0.04, brightness:0.19, alpha:1)
        labelLaunchLogin.font = NSFont(name: "Helvetica Neue", size: 15)
        labelLaunchLogin.alignment = NSTextAlignment.CenterTextAlignment
        labelLaunchLogin.sizeToFit()
        labelLaunchLogin.frame = NSMakeRect(150 + labelGeneral.frame.width, topSeparator.frame.origin.y - 40, labelLaunchLogin.frame.width, labelLaunchLogin.frame.height)
        self.view.addSubview(labelLaunchLogin)

        let switchLaunchLoginButton = NSButton(frame: NSMakeRect(labelLaunchLogin.frame.origin.x - 17.5, labelLaunchLogin.frame.origin.y, 18, 18))
        switchLaunchLoginButton.bordered = false
        switchLaunchLoginButton.setButtonType(NSButtonType.SwitchButton)
        switchLaunchLoginButton.title = ""
        switchLaunchLoginButton.target = self
        switchLaunchLoginButton.action = "onSwitchLaunchLoginButtonPressed:"
        self.view.addSubview(switchLaunchLoginButton)

        let labelSoundWhenDone = NSTextField()
        labelSoundWhenDone.bordered = false
        labelSoundWhenDone.bezeled = false
        labelSoundWhenDone.editable = false
        labelSoundWhenDone.selectable = false
        labelSoundWhenDone.drawsBackground = false
        labelSoundWhenDone.stringValue = "Play notification sound"
        labelSoundWhenDone.textColor = NSColor(calibratedHue:1, saturation:0.04, brightness:0.19, alpha:1)
        labelSoundWhenDone.font = NSFont(name: "Helvetica Neue", size: 15)
        labelSoundWhenDone.alignment = NSTextAlignment.CenterTextAlignment
        labelSoundWhenDone.sizeToFit()
        labelSoundWhenDone.frame = NSMakeRect(150 + labelGeneral.frame.width, topSeparator.frame.origin.y - 80, labelSoundWhenDone.frame.width, labelSoundWhenDone.frame.height)
        self.view.addSubview(labelSoundWhenDone)

        let switchPlaySoundButton = NSButton(frame: NSMakeRect(labelSoundWhenDone.frame.origin.x - 17.5, labelSoundWhenDone.frame.origin.y, 18, 18))
        switchPlaySoundButton.bordered = false
        switchPlaySoundButton.setButtonType(NSButtonType.SwitchButton)
        switchPlaySoundButton.title = ""
        switchPlaySoundButton.target = self
        switchPlaySoundButton.action = "onSwitchPlaySoundButtonPressed:"
        self.view.addSubview(switchPlaySoundButton)

        let bottomSeparator = NSView(frame: NSMakeRect(0, labelSoundWhenDone.frame.origin.y - 30, self.view.frame.width, 1))
        bottomSeparator.wantsLayer = true
        bottomSeparator.layer?.backgroundColor = NSColor.lightGrayColor().CGColor
        self.view.addSubview(bottomSeparator)

        let labelName = NSTextField()
        labelName.bezeled = false
        labelName.bordered = false
        labelName.editable = false
        labelName.selectable = false
        labelName.drawsBackground = false
        labelName.attributedStringValue = TextSplitter.checkNewStringForTextField("Ramon Gilabert", fontSize: 25)
        labelName.sizeToFit()
        labelName.frame = NSMakeRect((self.view.frame.width - labelName.frame.width)/2, bottomSeparator.frame.origin.y - labelName.frame.height - 25, labelName.frame.width, labelName.frame.height)
        self.view.addSubview(labelName)

        let buttonTwitter = NSButton(frame: NSMakeRect((self.view.frame.width - 64)/2 - 100, labelName.frame.origin.y - 83, 64, 66))
        buttonTwitter.image = NSImage(named: "twitter-icon-social")
        buttonTwitter.bordered = false
        buttonTwitter.setButtonType(NSButtonType.MomentaryChangeButton)
        buttonTwitter.target = self
        buttonTwitter.action = "onTwitterButtonPressed"
        self.view.addSubview(buttonTwitter)

        let buttonWebsite = NSButton(frame: NSMakeRect((self.view.frame.width - 64)/2 + 100, labelName.frame.origin.y - 83, 64, 66))
        buttonWebsite.image = NSImage(named: "dribbble-icon-social")
        buttonWebsite.bordered = false
        buttonWebsite.setButtonType(NSButtonType.MomentaryChangeButton)
        buttonWebsite.target = self
        buttonWebsite.action = "onDribbbleButtonPressed"
        self.view.addSubview(buttonWebsite)

        let buttonEmail = NSButton(frame: NSMakeRect((self.view.frame.width - 64)/2, labelName.frame.origin.y - 83, 64, 66))
        buttonEmail.image = NSImage(named: "email-icon-social")
        buttonEmail.bordered = false
        buttonEmail.setButtonType(NSButtonType.MomentaryChangeButton)
        buttonEmail.target = self
        buttonEmail.action = "onEmailButtonPressed"
        self.view.addSubview(buttonEmail)

    }

    // MARK: Action handlers

    func onClosePreferencesButtonPressed() {
        self.popoverManager?.delegate?.configureThatView!()
        self.view.window?.close()
        self.popoverManager?.delegate!.openThatPopover!()
    }

    func onQuitAppButtonPressed() {
        NSApplication.sharedApplication().terminate(self)
    }

    func onSwitchLaunchLoginButtonPressed(sender: NSButton) {

    }

    func onSwitchPlaySoundButtonPressed(sender: NSButton) {

    }

    func onTwitterButtonPressed() {

    }

    func onDribbbleButtonPressed() {

    }

    func onEmailButtonPressed() {

    }
}
