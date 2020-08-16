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
    
    @objc open func willMove(to window: SKWindow) {
        // override point
    }

    #if os(macOS)
    open override func viewWillMove(toWindow newWindow: NSWindow?) {
        guard let window = newWindow else { return }
        willMove(to: window)
    }
    #else
    open override func willMove(toWindow newWindow: UIWindow?) {
        guard let window = newWindow else { return }
        willMove(to: window)
    }
    #endif
}
