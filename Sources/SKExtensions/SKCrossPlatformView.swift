open class SKCrossPlatformView: SKView {}


extension SKCrossPlatformView {
    
    open func willMove(to window: SKWindow?) {
        ignoresSiblingOrder = true
    }

    #if os(macOS)
    open override func viewWillMove(toWindow newWindow: NSWindow?) {
        willMove(to: newWindow)
        super.viewWillMove(toWindow: newWindow)
    }
    #else
    open override func willMove(toWindow newWindow: UIWindow?) {
        willMove(to: newWindow)
        super.willMove(toWindow: newWindow)
    }
    #endif
}
