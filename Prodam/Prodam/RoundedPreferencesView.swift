import Cocoa

class RoundedPreferencesView: NSView {

    let visualEffectView = NSVisualEffectView()

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        self.visualEffectView.frame = dirtyRect
        self.visualEffectView.state = NSVisualEffectState.Active
        self.visualEffectView.material = NSVisualEffectMaterial.Light
        self.addSubview(self.visualEffectView)
    }
}
