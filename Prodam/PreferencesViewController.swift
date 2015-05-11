import Cocoa

class PreferencesViewController: NSViewController {

    let viewModel = ViewModel()

    override func loadView() {
        self.view = NSView(frame: NSMakeRect(0, 0, 500, 360))

        let titlePreferences = NSTextField()
        titlePreferences.frame = NSMakeRect(0, 0, 0, 0)
        titlePreferences.bordered = false
        titlePreferences.bezeled = false
        titlePreferences.editable = false
        titlePreferences.selectable = false
        titlePreferences.stringValue = "Preferences"
        titlePreferences.font = NSFont(name: "Helvetica Neue", size: 20)
        titlePreferences.alignment = NSTextAlignment.CenterTextAlignment
        titlePreferences.sizeToFit()
        titlePreferences.frame = NSMakeRect(self.view.frame.height - titlePreferences.frame.height - 25, (self.view.frame.width - titlePreferences.frame.width)/2, titlePreferences.frame.width, titlePreferences.frame.height)
        self.view.addSubview(titlePreferences)

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
