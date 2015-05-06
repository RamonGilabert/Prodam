import Cocoa

class RoundedCornerView: NSView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        NSColor.windowBackgroundColor().set()
        NSRectFill(dirtyRect)
    }
}
