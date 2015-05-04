import Cocoa

struct Constant {
    struct Window {
        static let Width = 300 as CGFloat
        static let Height = 200 as CGFloat
    }

    struct MainWindowLayout {
        static let MinimumPaddingButton = 6 as CGFloat
        static let HeightOfButton = Constant.Window.Height / 3.5
    }
}

class ViewModel: NSObject {

}
