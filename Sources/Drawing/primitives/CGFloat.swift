extension BinaryInteger {
    @inlinable public var cg: CGFloat { .init(self) }
    @inlinable public var π: CGFloat { cg.π }
}

extension BinaryFloatingPoint {
    @inlinable public var cg: CGFloat { .init(self) }
    @inlinable public var π: CGFloat { cg.π }
}

extension CGFloat {
    public static let π: CGFloat = .pi
    @inlinable public var π: CGFloat { self * .pi }
    @inlinable public var abs: CGFloat { Swift.abs(self) }
}

extension CGFloat {
    @inlinable public func acos() -> CGFloat { CoreGraphics.acos(self) }
    @inlinable public func acosh() -> CGFloat { CoreGraphics.acosh(self) }
    @inlinable public func asin() -> CGFloat { CoreGraphics.asin(self) }
    @inlinable public func asinh() -> CGFloat { CoreGraphics.asinh(self) }
    @inlinable public func atan() -> CGFloat { CoreGraphics.atan(self) }
    @inlinable public func atanh() -> CGFloat { CoreGraphics.atanh(self) }
    @inlinable public func cbrt() -> CGFloat { CoreGraphics.cbrt(self) }
    @inlinable public func cos() -> CGFloat { CoreGraphics.cos(self) }
    @inlinable public func cosh() -> CGFloat { CoreGraphics.cosh(self) }
    @inlinable public func erf() -> CGFloat { CoreGraphics.erf(self) }
    @inlinable public func erfc() -> CGFloat { CoreGraphics.erfc(self) }
    @inlinable public func exp() -> CGFloat { CoreGraphics.exp(self) }
    @inlinable public func exp2() -> CGFloat { CoreGraphics.exp2(self) }
    @inlinable public func expm1() -> CGFloat { CoreGraphics.expm1(self) }
    @inlinable public func j0() -> CGFloat { CoreGraphics.j0(self) }
    @inlinable public func j1() -> CGFloat { CoreGraphics.j1(self) }
    @inlinable public func log() -> CGFloat { CoreGraphics.log(self) }
    @inlinable public func log10() -> CGFloat { CoreGraphics.log10(self) }
    @inlinable public func log1p() -> CGFloat { CoreGraphics.log1p(self) }
    @inlinable public func log2() -> CGFloat { CoreGraphics.log2(self) }
    @inlinable public func logb() -> CGFloat { CoreGraphics.logb(self) }
    @inlinable public func nearbyint() -> CGFloat { CoreGraphics.nearbyint(self) }
    @inlinable public func rint() -> CGFloat { CoreGraphics.rint(self) }
    @inlinable public func sin() -> CGFloat { CoreGraphics.sin(self) }
    @inlinable public func sinh() -> CGFloat { CoreGraphics.sinh(self) }
    @inlinable public func tan() -> CGFloat { CoreGraphics.tan(self) }
    @inlinable public func tanh() -> CGFloat { CoreGraphics.tanh(self) }
    @inlinable public func tgamma() -> CGFloat { CoreGraphics.tgamma(self) }
    @inlinable public func y0() -> CGFloat { CoreGraphics.y0(self) }
    @inlinable public func y1() -> CGFloat { CoreGraphics.y1(self) }
}

extension CGFloat {
    @inlinable public func pow(_ exp: CGFloat) -> CGFloat { CoreGraphics.pow(self, exp) }
    @inlinable public func signed(as other: CGFloat) -> CGFloat { copysign(self, other) }
}

extension CGFloat {
    
    @inlinable public func random(withinDistance max: CGFloat, pow: CGFloat = 2) -> CGFloat {
        random(withinDistance: max, by: { $0.pow(pow) })
    }
}

extension CGFloat: CustomDebugStringConvertible {
    @inlinable public var debugDescription: String { description }
}

extension CGFloat { // TODO: generalse in Space
    
    @inlinable public static func ± (l: CGFloat, r: (max: CGFloat, pow: CGFloat)) -> CGFloat {
        l.random(withinDistance: r.max, by: { $0.pow(r.pow) })
    }
    
    @inlinable public static func ± (l: CGFloat, r: (max: CGFloat, pow: CGFloat, range: PartialRangeFrom<CGFloat>)) -> CGFloat {
        (l ± (r.max, r.pow)).clamped(to: r.range)
    }
    
    @inlinable public static func ± (l: CGFloat, r: (max: CGFloat, pow: CGFloat, range: PartialRangeUpTo<CGFloat>)) -> CGFloat {
        (l ± (r.max, r.pow)).clamped(to: r.range)
    }
    
    @inlinable public static func ± (l: CGFloat, r: (max: CGFloat, pow: CGFloat, range: ClosedRange<CGFloat>)) -> CGFloat {
        (l ± (r.max, r.pow)).clamped(to: r.range)
    }
}

extension CGFloat { // TODO: generalse in Space
    
    @inlinable public static func ±= (l: inout CGFloat, r: (max: CGFloat, pow: CGFloat)) {
        l = l ± r
    }
    
    @inlinable public static func ±= (l: inout CGFloat, r: (max: CGFloat, pow: CGFloat, range: PartialRangeFrom<CGFloat>)) {
        l = l ± r
    }
    
    @inlinable public static func ±= (l: inout CGFloat, r: (max: CGFloat, pow: CGFloat, range: PartialRangeUpTo<CGFloat>)) {
        l = l ± r
    }
    
    @inlinable public static func ±= (l: inout CGFloat, r: (max: CGFloat, pow: CGFloat, range: ClosedRange<CGFloat>)) {
        l = l ± r
    }
}

extension CGFloat { // TODO: generalse in Space
    
    @inlinable public static func += (l: inout CGFloat, r: (x: CGFloat, range: PartialRangeFrom<CGFloat>)) {
        l = (l + r.x).clamped(to: r.range)
    }
    
    @inlinable public static func += (l: inout CGFloat, r: (x: CGFloat, range: PartialRangeUpTo<CGFloat>)) {
        l = (l + r.x).clamped(to: r.range)
    }
    
    @inlinable public static func += (l: inout CGFloat, r: (x: CGFloat, range: ClosedRange<CGFloat>)) {
        l = (l + r.x).clamped(to: r.range)
    }
}

extension CGFloat { // TODO: generalse in Space
    
    @inlinable public static func -= (l: inout CGFloat, r: (x: CGFloat, range: PartialRangeFrom<CGFloat>)) {
        l = (l - r.x).clamped(to: r.range)
    }
    
    @inlinable public static func -= (l: inout CGFloat, r: (x: CGFloat, range: PartialRangeUpTo<CGFloat>)) {
        l = (l - r.x).clamped(to: r.range)
    }
    
    @inlinable public static func -= (l: inout CGFloat, r: (x: CGFloat, range: ClosedRange<CGFloat>)) {
        l = (l - r.x).clamped(to: r.range)
    }
}

extension CGFloat { // TODO: generalse in Space
    
    @inlinable public static func *= (l: inout CGFloat, r: (x: CGFloat, range: PartialRangeFrom<CGFloat>)) {
        l = (l * r.x).clamped(to: r.range)
    }
    
    @inlinable public static func *= (l: inout CGFloat, r: (x: CGFloat, range: PartialRangeUpTo<CGFloat>)) {
        l = (l * r.x).clamped(to: r.range)
    }
    
    @inlinable public static func *= (l: inout CGFloat, r: (x: CGFloat, range: ClosedRange<CGFloat>)) {
        l = (l * r.x).clamped(to: r.range)
    }
}

extension CGFloat { // TODO: generalse in Space
    
    @inlinable public static func /= (l: inout CGFloat, r: (x: CGFloat, range: PartialRangeFrom<CGFloat>)) {
        l = (l / r.x).clamped(to: r.range)
    }
    
    @inlinable public static func /= (l: inout CGFloat, r: (x: CGFloat, range: PartialRangeUpTo<CGFloat>)) {
        l = (l / r.x).clamped(to: r.range)
    }
    
    @inlinable public static func /= (l: inout CGFloat, r: (x: CGFloat, range: ClosedRange<CGFloat>)) {
        l = (l / r.x).clamped(to: r.range)
    }
}
