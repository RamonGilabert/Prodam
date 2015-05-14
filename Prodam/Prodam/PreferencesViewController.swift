import Cocoa

class PreferencesViewController: NSViewController {

    let viewModel = ViewModel()
    let userDefaults = NSUserDefaults.standardUserDefaults()
    var popoverManager: PopoverManager?

    override func loadView() {
        self.view = NSView(frame: NSMakeRect(0, 0, 460, 320))

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

        let switchLaunchLoginButton = NSButton(frame: NSMakeRect(labelLaunchLogin.frame.origin.x - 17.5, labelLaunchLogin.frame.origin.y, 18, 18))
        switchLaunchLoginButton.bordered = false
        switchLaunchLoginButton.setButtonType(NSButtonType.SwitchButton)
        switchLaunchLoginButton.title = ""
        switchLaunchLoginButton.target = self
        switchLaunchLoginButton.action = "onSwitchLaunchLoginButtonPressed:"
        switchLaunchLoginButton.integerValue = Int(self.userDefaults.boolForKey("startLaunch"))
        self.view.addSubview(switchLaunchLoginButton)

        let switchPlaySoundButton = NSButton(frame: NSMakeRect(labelSoundWhenDone.frame.origin.x - 17.5, labelSoundWhenDone.frame.origin.y, 18, 18))
        switchPlaySoundButton.bordered = false
        switchPlaySoundButton.setButtonType(NSButtonType.SwitchButton)
        switchPlaySoundButton.title = ""
        switchPlaySoundButton.target = self
        switchPlaySoundButton.action = "onSwitchPlaySoundButtonPressed:"
        switchPlaySoundButton.integerValue = Int(self.userDefaults.boolForKey("soundDone"))
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
        self.userDefaults.setBool(Bool(sender.integerValue), forKey: "startLaunch")
        toggleLaunchAtStartup()
        self.userDefaults.synchronize()
    }

    func onSwitchPlaySoundButtonPressed(sender: NSButton) {
        self.userDefaults.setBool(Bool(sender.integerValue), forKey: "soundDone")
        self.userDefaults.synchronize()
    }

    func onTwitterButtonPressed() {
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: "http://www.twitter.com/RamonGilabert")!)
    }

    func onDribbbleButtonPressed() {
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: "https://dribbble.com/RamonGilabert")!)
    }

    func onEmailButtonPressed() {
        let emailAddress = "contact@ramongilabert.com"
        let emailSubject = "Hey! :)"
        let emailBody = "Just wanted to say hello: "
        let emailString = "mailto:\(emailAddress)?Subject=\(emailSubject)&body=\(emailBody)"
        let realEmailString = emailString.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: nil, range: nil)
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: realEmailString)!)
    }

    // MARK: Launch at startup

    func applicationIsInStartUpItems() -> Bool {
        return (itemReferencesInLoginItems().existingReference != nil)
    }

    func itemReferencesInLoginItems() -> (existingReference: LSSharedFileListItemRef?, lastReference: LSSharedFileListItemRef?) {
        if let appURL : NSURL = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath) {
            if let loginItemsRef = LSSharedFileListCreate(nil, kLSSharedFileListSessionLoginItems.takeRetainedValue(), nil).takeRetainedValue() as LSSharedFileListRef? {

                let loginItems: NSArray = LSSharedFileListCopySnapshot(loginItemsRef, nil).takeRetainedValue() as NSArray
                let lastItemRef: LSSharedFileListItemRef = loginItems.lastObject as! LSSharedFileListItemRef

                for var i = 0; i < loginItems.count; ++i {
                    let currentItemRef: LSSharedFileListItemRef = loginItems.objectAtIndex(i) as! LSSharedFileListItemRef
                    if let itemURL = LSSharedFileListItemCopyResolvedURL(currentItemRef, 0, nil) {
                        if (itemURL.takeRetainedValue() as NSURL).isEqual(appURL) {
                            return (currentItemRef, lastItemRef)
                        }
                    }
                }

                return (nil, lastItemRef)
            }
        }

        return (nil, nil)
    }

    func toggleLaunchAtStartup() {
        let itemReferences = itemReferencesInLoginItems()
        let shouldBeToggled = (itemReferences.existingReference == nil)
        if let loginItemsRef = LSSharedFileListCreate( nil, kLSSharedFileListSessionLoginItems.takeRetainedValue(), nil).takeRetainedValue() as LSSharedFileListRef? {
            if shouldBeToggled {
                if let appUrl : CFURLRef = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath) {
                    LSSharedFileListInsertItemURL(loginItemsRef, itemReferences.lastReference, nil, nil, appUrl, nil, nil)
                }
            } else {
                if let itemRef = itemReferences.existingReference {
                    LSSharedFileListItemRemove(loginItemsRef,itemRef);
                }
            }
        }
    }
}
