import Cocoa

class BreakWindow: NSWindow {

    override var canBecomeMainWindow: Bool {
        get {
            return true
        }
    }

    override var canBecomeKeyWindow: Bool {
        get {
            return true
        }
    }

    override var contentView: AnyObject {
        set (_view) {
            let view = _view as! NSView
            view.wantsLayer = true
            view.layer!.frame = view.frame
            view.layer!.cornerRadius = 7
            view.layer!.masksToBounds = true

            super.contentView = view
        }

        get {
            return super.contentView
        }
    }

    override init(contentRect: NSRect, styleMask aStyle: Int, backing bufferingType: NSBackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: aStyle, backing: bufferingType, defer: flag)
        self.opaque = false
        self.movableByWindowBackground = true
        self.backgroundColor = NSColor.clearColor()
        self.hasShadow = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
