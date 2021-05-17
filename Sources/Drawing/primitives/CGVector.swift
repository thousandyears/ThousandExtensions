extension CGVector: Real2D {
    @inlinable public var tuple: (CGFloat, CGFloat) { (dx, dy) }
    @inlinable public init(_ tuple: (CGFloat, CGFloat)) { self.init(dx: tuple.0, dy: tuple.1) }
}

extension CGVector {
    
    @inlinable public mutating func apply(_ t: CGAffineTransform) {
        self = applying(t)
    }
    
    @inlinable public func applying(_ t: CGAffineTransform) -> CGVector {
        cast(to: CGPoint.self).applying(t).cast()
    }
}
