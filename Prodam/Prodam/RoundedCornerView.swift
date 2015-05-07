import Cocoa

class RoundedCornerView: NSView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        NSColor.blackColor().set()
        NSRectFill(dirtyRect)
        self.appearance = NSAppearance(named: NSAppearanceNameAqua)

        let visualEffectView = NSVisualEffectView(frame: dirtyRect)
        visualEffectView.state = NSVisualEffectState.Active
        visualEffectView.material = NSVisualEffectMaterial.Dark
        self.addSubview(visualEffectView)
    }
}
