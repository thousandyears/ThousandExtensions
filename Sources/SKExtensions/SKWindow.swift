#if canImport(AppKit)
public typealias SKWindow = NSWindow
#endif

#if canImport(UIKit)
public typealias SKWindow = UIWindow
#endif

public extension SKWindow {
    
    var scaleFactor: CGFloat {
        // TODO: This is to simply park the question of the screen scaling factor until we're ready to deal with the full subtlety of the challenge
        #if canImport(AppKit)
        return backingScaleFactor
        #elseif canImport(UIKit)
        return contentScaleFactor
        #else
        return 2
        #endif
    }
}

extension SKNode {
    
    // TODO: This is to simply park the question of the screen scaling factor until we're ready to deal with the full subtlety of the challenge
    @inlinable public var scaleFactor: CGFloat? { 2 }
}
