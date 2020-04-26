#if canImport(AppKit)
public class SKQuickWindow: NSWindow {
    
    public let view: SKQuickView = .init()
    public var scene: SKQuickScene { view.larkingScene }
    
    public init(width: CGFloat = 1024, height: CGFloat = 768) {
        super.init(
            contentRect: CGRect(width: width, height: height),
            styleMask: [
                .titled,
                .closable,
                .miniaturizable,
                .resizable,
//                .fullSizeContentView
            ],
            backing: .buffered,
            defer: false
        )
        title = "App"
        isMovableByWindowBackground = true
        // titlebarAppearsTransparent = true
        // aspectRatio = .init(width: 19.5, height: 9)
        contentView = view
        setFrameAutosaveName(title)
        makeKeyAndOrderFront(nil)
        acceptsMouseMovedEvents = true
        
    }
}
#endif
