open class SKQuickWindow: SKWindow {

    #if canImport(AppKit)
    public required init(
        size: CGSize,
        style: StyleMask = [
            .titled,
            .closable,
            .miniaturizable,
            .resizable
        ]
    ) {
        super.init(
            contentRect: .init(origin: .zero, size: size),
            styleMask: style,
            backing: .buffered,
            defer: false
        )
        center()
        title = "Thousand Years"
        setFrameAutosaveName(title)
        acceptsMouseMovedEvents = true
        contentView = SKQuickView()
        makeKeyAndOrderFront(nil)
    }
    #endif
    
    
}


#if canImport(AppKit)
extension SKQuickWindow {
    open var quickView: SKQuickView {
        get { contentView as! SKQuickView }
        set { contentView = newValue }
    }
    
    open override var contentView: NSView? {
        get { super.contentView }
        set { if let o = newValue as? SKQuickView { super.contentView = o } }
    }
    
    open override var title: String {
        didSet { setFrameAutosaveName(title) }
    }
    
    open func applicationShouldTerminateAfterLastWindowClosed(_: NSApplication) -> Bool {
        true
    }
}
#endif
