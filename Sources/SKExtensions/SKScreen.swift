#if canImport(AppKit)
    public typealias SKScreen = NSScreen
#elseif canImport(UIKit)
    public typealias SKScreen = UIScreen
#endif

extension SKScreen {
    
    public static var scaleFactor: CGFloat {
        #if canImport(AppKit)
        return main?.backingScaleFactor ?? 1
        #elseif canImport(UIKit)
        return main.scale
        #else
        return 1
        #endif
    }
}
