import Cocoa

protocol ViewClicked {
    func buttonClicked()
}

class PopoverView: NSView, ViewClicked {

    var delegate: ViewClicked?

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
    }

    override func rightMouseDown(theEvent: NSEvent) {
        delegate?.buttonClicked()
        self.alphaValue = 1
    }

    override func otherMouseDown(theEvent: NSEvent) {
        delegate?.buttonClicked()
        self.alphaValue = 1
    }

    override func mouseDown(theEvent: NSEvent) {
        delegate?.buttonClicked()
        self.alphaValue = 1
    }

    func buttonClicked() { }
}
