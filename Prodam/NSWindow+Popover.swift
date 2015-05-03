import Cocoa

class NSWindow_Popover: NSWindow {

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
}
