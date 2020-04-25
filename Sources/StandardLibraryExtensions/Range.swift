extension ClosedRange where Bound: BinaryFloatingPoint, Bound.RawSignificand: FixedWidthInteger {
    @inlinable public func random() -> Bound { Bound.random(in: self) }
}
