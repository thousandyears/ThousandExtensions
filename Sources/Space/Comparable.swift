extension Comparable {

    @inlinable public func isBetween(_ this: Self, and that: Self) -> Bool {
        let (l, u) = this < that ? (this, that) : (that, this)
        return l <= self && self <= u
    }
}

extension Comparable {
    
    @inlinable public func clamped(to range: ClosedRange<Self>) -> Self {
        (self...self).clamped(to: range).lowerBound
    }
    
    @inlinable public func clamped(to range: PartialRangeFrom<Self>) -> Self {
        (self...self).clamped(to: range).lowerBound
    }
    
    @inlinable public func clamped(to range: PartialRangeUpTo<Self>) -> Self {
        (self..<self).clamped(to: range).lowerBound
    }
    
    @inlinable public func clamped(to range: PartialRangeThrough<Self>) -> Self {
        (self...self).clamped(to: range).lowerBound
    }
}

