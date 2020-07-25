extension ClosedRange: Real2D where Bound: Real {
    @inlinable public var tuple: (Bound, Bound) { (lowerBound, upperBound) }
    @inlinable public init(_ tuple: (Bound, Bound)) { self = tuple.0 ... tuple.1 }
    @inlinable public var range: ClosedRange<Bound> { self }
    @inlinable public var min: Bound { lowerBound }
    @inlinable public var max: Bound { upperBound }
}

extension ClosedRange where Bound: AdditiveArithmetic {
    
    @inlinable public var span: Bound { upperBound - lowerBound }
    
    public enum Advance: String, Codable, Equatable {
        case upperBound
        case lowerBound
    }
    
    @inlinable public mutating func advance(_ advance: Advance, by offset: Bound) {
        switch advance {
        case .upperBound:
            let o = upperBound + offset
            self = Swift.min(o, lowerBound) ... o
        case .lowerBound:
            let o = lowerBound + offset
            self = o ... Swift.max(o, upperBound)
        }
    }
}

extension ClosedRange {
    public init(between: Bound, and: Bound) {
        self = between < and ? between ... and : and ... between
    }
}

extension ClosedRange {
    
    @inlinable public func clamped(to range: PartialRangeFrom<Bound>) -> Self {
        clamped(to: range.lowerBound ... Swift.max(upperBound, range.lowerBound))
    }

    @inlinable public func clamped(to range: PartialRangeThrough<Bound>) -> Self {
        clamped(to: Swift.min(lowerBound, range.upperBound) ... range.upperBound)
    }
}

extension Range {
    
    @inlinable public func clamped(to range: PartialRangeUpTo<Bound>) -> Self {
        clamped(to: Swift.min(lowerBound, range.upperBound) ..< range.upperBound)
    }
}

@inlinable public func stride<A>(over range: ClosedRange<A>, by stride: A.Stride) -> StrideThrough<A>
    where A: Strideable
{
    Swift.stride(from: range.lowerBound, through: range.upperBound, by: stride)
}

@inlinable public func stride<A>(over range: ClosedRange<A>, count: Int) -> StrideTo<A>
    where A: BinaryFloatingPoint, A.Stride == A
{
    Swift.stride(from: range.lowerBound, to: range.upperBound, by: (range.upperBound - range.lowerBound) / A(count))
}

@inlinable public func stride<A>(over range: Range<A>, by stride: A.Stride) -> StrideTo<A>
    where A: Strideable
{
    Swift.stride(from: range.lowerBound, to: range.upperBound, by: stride)
}

@inlinable public func stride<A>(over range: Range<A>, count: Int) -> StrideTo<A>
    where A: BinaryFloatingPoint, A.Stride == A
{
    Swift.stride(from: range.lowerBound, to: range.upperBound, by: (range.upperBound - range.lowerBound) / A(count))
}
