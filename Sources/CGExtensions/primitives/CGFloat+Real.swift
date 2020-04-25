extension CGFloat: ElementaryFunctions {
    @inlinable public static func cos(_ x: CGFloat) -> CGFloat { CoreGraphics.cos(x) }
    @inlinable public static func sin(_ x: CGFloat) -> CGFloat { CoreGraphics.sin(x) }
    @inlinable public static func tan(_ x: CGFloat) -> CGFloat { CoreGraphics.tan(x) }
    @inlinable public static func acos(_ x: CGFloat) -> CGFloat { CoreGraphics.acos(x) }
    @inlinable public static func asin(_ x: CGFloat) -> CGFloat { CoreGraphics.asin(x) }
    @inlinable public static func atan(_ x: CGFloat) -> CGFloat { CoreGraphics.atan(x) }
    @inlinable public static func cosh(_ x: CGFloat) -> CGFloat { CoreGraphics.cosh(x) }
    @inlinable public static func sinh(_ x: CGFloat) -> CGFloat { CoreGraphics.sinh(x) }
    @inlinable public static func tanh(_ x: CGFloat) -> CGFloat { CoreGraphics.tanh(x) }
    @inlinable public static func acosh(_ x: CGFloat) -> CGFloat { CoreGraphics.acosh(x) }
    @inlinable public static func asinh(_ x: CGFloat) -> CGFloat { CoreGraphics.asinh(x) }
    @inlinable public static func atanh(_ x: CGFloat) -> CGFloat { CoreGraphics.atanh(x) }
    @inlinable public static func exp(_ x: CGFloat) -> CGFloat { CoreGraphics.exp(x) }
    @inlinable public static func expMinusOne(_ x: CGFloat) -> CGFloat { CoreGraphics.expm1(x) }
    @inlinable public static func log(_ x: CGFloat) -> CGFloat { CoreGraphics.log(x) }
    @inlinable public static func log(onePlus x: CGFloat) -> CGFloat { CoreGraphics.log1p(x) }
    @inlinable public static func pow(_ x: CGFloat, _ y: CGFloat) -> CGFloat { Double.pow(x.d, y.d).cg }
    @inlinable public static func pow(_ x: CGFloat, _ n: Int) -> CGFloat { Double.pow(x.d, n).cg }
    @inlinable public static func sqrt(_ x: CGFloat) -> CGFloat { CoreGraphics.sqrt(x) }
    @inlinable public static func root(_ x: CGFloat, _ n: Int) -> CGFloat { (Double.root(x.d, n)).cg }
}

extension CGFloat: Real {
    @inlinable public static func atan2(y: CGFloat, x: CGFloat) -> CGFloat { CoreGraphics.atan2(y, x) }
    @inlinable public static func erf(_ x: CGFloat) -> CGFloat { CoreGraphics.erf(x) }
    @inlinable public static func erfc(_ x: CGFloat) -> CGFloat { CoreGraphics.erfc(x) }
    @inlinable public static func exp2(_ x: CGFloat) -> CGFloat { CoreGraphics.exp2(x) }
    @inlinable public static func hypot(_ x: CGFloat, _ y: CGFloat) -> CGFloat { CoreGraphics.hypot(x, y) }
    @inlinable public static func gamma(_ x: CGFloat) -> CGFloat { CoreGraphics.tgamma(x) }
    @inlinable public static func log2(_ x: CGFloat) -> CGFloat { CoreGraphics.log2(x) }
    @inlinable public static func log10(_ x: CGFloat) -> CGFloat { CoreGraphics.log10(x) }
    @inlinable public static func logGamma(_ x: CGFloat) -> CGFloat { (Double.logGamma(x.d)).cg }
}
