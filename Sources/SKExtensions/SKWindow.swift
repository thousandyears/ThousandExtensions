#if canImport(AppKit)
    public typealias SKWindow = NSWindow
#elseif canImport(UIKit)
    public typealias SKWindow = UIWindow
#endif

public extension SKWindow {
    
    var scaleFactor: CGFloat {
        #if canImport(AppKit)
        return backingScaleFactor
        #elseif canImport(UIKit)
        return SKScreen.scaleFactor
        #else
        return 1
        #endif
    }
}

