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
        LaunchStarter.toggleLaunchAtStartup()
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
}
