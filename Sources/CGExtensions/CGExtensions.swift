@_exported import SwiftExtensions
@_exported import Drawing

#if canImport(UIKit)
extension CGColor {
    public static var white: CGColor {
        return .init(srgbRed: 1, green: 1, blue: 1, alpha: 1)
    }
}
#endif
