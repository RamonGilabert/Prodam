import Cocoa

class RoundedCornerView: NSView {

    let visualEffectView = NSVisualEffectView()

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        self.visualEffectView.frame = dirtyRect
        self.visualEffectView.state = NSVisualEffectState.Active
        self.visualEffectView.material = NSVisualEffectMaterial.Dark
        self.addSubview(self.visualEffectView)
    }
}
