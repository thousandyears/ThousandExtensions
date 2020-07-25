extension Real where Self: BinaryFloatingPoint, RawSignificand: FixedWidthInteger {
    
    @inlinable public static func random(
        in range: ClosedRange<Self>,
        median: Self,
        power exp: Self
    ) -> Self {
        random(in: range, median: median, by: { .pow($0, exp) })
    }
}

extension Real where Self: BinaryFloatingPoint {
    
    @inlinable public func cast<Other>(to: Other.Type = Other.self) -> Other where Other: BinaryFloatingPoint {
        Other(self)
    }
}

extension Real {
    
    @inlinable public static func relu(_ x: Self) -> Self {
        .maximum(0, x)
    }
}
