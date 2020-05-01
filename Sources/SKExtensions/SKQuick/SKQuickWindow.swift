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
    
    public required init() {
        super.init(
            contentRect: .init(origin: .zero, size: .init(width: 512, height: 512)),
            styleMask: [
                .titled,
                .closable,
                .miniaturizable,
                .resizable
            ],
            backing: .buffered,
            defer: false
        )
        title = "Thousand Years"
        titlebarAppearsTransparent = false
        contentView = SKQuickView()
        setFrameAutosaveName(title)
        makeKeyAndOrderFront(nil)
        acceptsMouseMovedEvents = true
    }
}
#endif
