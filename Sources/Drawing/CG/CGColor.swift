#if !os(macOS)
extension CGColor {
    
    public static var white: CGColor { .init(genericGrayGamma2_2Gray: 1, alpha: 1) }
}
#endif
