#if os(macOS)

extension SKQuickWindow: NSApplicationDelegate {
    
    public var window: SKWindow { self }

    open func applicationShouldTerminateAfterLastWindowClosed(_: NSApplication) -> Bool {
        true
    }
}

open class SKQuickWindow: NSWindow {

    open var quickView: SKQuickView {
        get { contentView as! SKQuickView }
        set { contentView = newValue }
    }
    
    open override var contentView: NSView? {
        get { super.contentView }
        set { if let o = newValue as? SKQuickView { super.contentView = o } }
    }
    
    public convenience init() {
        self.init(size: .init(square: 512))
        title = "Thousand Years"
    }
    
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
        setFrameAutosaveName(title)
        acceptsMouseMovedEvents = true
        contentView = SKQuickView()
        makeKeyAndOrderFront(nil)
    }
}
#endif
