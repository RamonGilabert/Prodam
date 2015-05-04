import Cocoa

protocol ViewClicked {
    func buttonClicked()
}

class PopoverView: NSView, ViewClicked {

    var delegate: ViewClicked?

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        let backgroundColor = NSColor.clearColor()
        backgroundColor.set()
        NSBezierPath.fillRect(dirtyRect)
    }

    override func rightMouseDown(theEvent: NSEvent) {
        delegate?.buttonClicked()
    }

    override func otherMouseDown(theEvent: NSEvent) {
        delegate?.buttonClicked()
    }

    override func mouseDown(theEvent: NSEvent) {
        delegate?.buttonClicked()
    }

    func buttonClicked() { }
}
