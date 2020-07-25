extension SignedNumeric where Self: Comparable {
    
    @inlinable public var unitSign: Self { self < 0 ? -1 : 1 }
    @inlinable public var negated: Self { -self }

    @inlinable public static func ± (l: Self, r: Self) -> ClosedRange<Self> {
        (l - abs(r)) ... (l + abs(r))
    }
}

extension FloatingPoint {
    
    @inlinable public static var π: Self { .pi }

    @inlinable public var ifFinite: Self? { isFinite ? self : nil }
    
    @inlinable public func rounded(toNearestMultipleOf x: Self) -> Self {
        (self / x).rounded(.toNearestOrAwayFromZero) * x
    }
}

extension BinaryFloatingPoint {
    @inlinable public var i: Int { Int(self) }
    @inlinable public var f: Float { Float(self) }
    @inlinable public var d: Double { Double(self) }
}

extension BinaryFloatingPoint {
    @inlinable public var isEven: Bool { Int(self) % 2 == 0 }
    @inlinable public var isOdd: Bool { Int(self) % 2 == 1 }
}

extension BinaryFloatingPoint where RawSignificand: FixedWidthInteger {
    
    @inlinable public static func random(between: Self, and: Self) -> Self {
        .random(in: between < and ? between...and : and...between)
    }
}

extension BinaryFloatingPoint where RawSignificand: FixedWidthInteger {
    
    @inlinable public func random(withinDistance max: Self, by unitDistribution: (Self) -> Self) -> Self {
        Self.random(in: self ± max, median: self, by: unitDistribution)
    }
    
    public static func random(
        in range: ClosedRange<Self>,
        median: Self,
        by unitDistribution: (Self) -> Self
    ) -> Self {
        let o = (median.clamped(to: range) - range.lowerBound) / range.span // TODO: check for 0
        let x = unitDistribution(random(in: 0...1))
        let l = range.lowerBound + o * range.span
        return (1 - x) * l + x * (Bool.random() ? range.upperBound : range.lowerBound)
    }
}
