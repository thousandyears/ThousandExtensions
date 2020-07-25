#if canImport(AppKit)
public typealias SKScreen = NSScreen
#endif

#if canImport(UIKit)
public typealias SKScreen = UIScreen
#endif

extension SKScreen {
    
    public class var scaleFactor: CGFloat {
        // TODO: This is to simply park the question of the screen scaling factor until we're ready to deal with the full subtlety of the challenge
        #if canImport(AppKit)
        return deepest?.backingScaleFactor ?? 1
        #elseif canImport(UIKit)
        return (main.mirrored ?? main).scale
        #else
        return 1
        #endif
    }
}
