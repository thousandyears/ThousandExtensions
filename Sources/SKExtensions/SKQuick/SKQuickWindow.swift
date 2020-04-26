#if os(macOS)

extension SKQuickWindow: NSApplicationDelegate {
    
    public var window: SKWindow { self }

    open func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}

open class SKQuickWindow: NSWindow {
    
    open var quickView: SKQuickView? {
        get { contentView as? SKQuickView }
        set { contentView = newValue }
    }
    
    public required init() {
        super.init(
            contentRect: .unit,
            styleMask: [
                .titled,
                .closable,
                .miniaturizable,
                .resizable,
                // .fullSizeContentView
            ],
            backing: .buffered,
            defer: false
        )
        title = "Thousand Years"
        isMovableByWindowBackground = true
        // titlebarAppearsTransparent = true
        // aspectRatio = .init(width: 19.5, height: 9)
        setFrameAutosaveName(title)
        makeKeyAndOrderFront(nil)
        acceptsMouseMovedEvents = true
    }
}
#endif
