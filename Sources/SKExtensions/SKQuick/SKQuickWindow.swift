#if os(macOS)
@available(*, deprecated, message: "Will be removed in future release of SKExtensions.")
open class SKQuickWindow: SKWindow, NSApplicationDelegate {
    
    public convenience init() {
        self.init(size: .unit)
    }

    public convenience init(
        size: CGSize,
        style: StyleMask = [
            .titled,
            .closable,
            .miniaturizable,
            .resizable
        ]
    ) {
        self.init(
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
