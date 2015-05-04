import Cocoa

struct Constant {
    struct Window {
        static let Width = 300 as CGFloat
        static let Height = 225 as CGFloat
    }

    struct MainWindowLayout {
        static let MinimumPaddingButton = 9 as CGFloat
        static let HeightOfButton = Constant.Window.Height / 4
    }
}

class ViewModel: NSObject {

}
