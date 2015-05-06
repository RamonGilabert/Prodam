import Cocoa

class BreakWindow: NSWindow {

    override init(contentRect: NSRect, styleMask aStyle: Int, backing bufferingType: NSBackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: aStyle, backing: bufferingType, defer: flag)
        self.opaque = false
        self.backgroundColor = NSColor.clearColor()
        self.movableByWindowBackground = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
