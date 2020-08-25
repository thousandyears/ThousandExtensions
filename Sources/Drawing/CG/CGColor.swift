#if !os(macOS)
extension CGColor {
    
    public static let black = CGColor(genericGrayGamma2_2Gray: 0, alpha: 1)
    public static let clear = CGColor(genericGrayGamma2_2Gray: 0, alpha: 0)
    public static let white = CGColor(genericGrayGamma2_2Gray: 1, alpha: 1)
}
#endif
