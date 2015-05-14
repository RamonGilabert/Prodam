import Cocoa

class PreferencesViewController: NSViewController {

    let viewModel = ViewModel()
    let userDefaults = NSUserDefaults.standardUserDefaults()
    var popoverManager: PopoverManager?

    override func loadView() {
        self.view = NSView(frame: NSMakeRect(0, 0, 460, 320))

        self.viewModel.layoutPreferencesView(self.view, viewController: self)
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
