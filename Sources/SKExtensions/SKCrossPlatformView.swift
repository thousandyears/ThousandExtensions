open class SKCrossPlatformView: SKView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        didInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        didInit()
    }
    
    open func didInit() {
        ignoresSiblingOrder = true
    }
}


extension SKCrossPlatformView {
    
    open func willMove(to window: SKWindow?) {
        // override point
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
