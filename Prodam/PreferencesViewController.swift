import Cocoa

class PreferencesViewController: NSViewController {

    let viewModel = ViewModel()

    override func loadView() {
        self.view = NSView(frame: NSMakeRect(0, 0, 500, 360))

        let titlePreferences = NSTextField()
        let buttonClosePreferences = NSButton()
        let buttonQuitLogin = NSButton()
        let topSeparator = NSView()
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
}
