#if canImport(AppKit)
open class SKQuickAppDelegate: NSObject, NSApplicationDelegate {

    public let window = SKQuickWindow()
    public var view: SKQuickView { window.view }
    public var scene: SKQuickScene { window.scene }

    open func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}
#endif
