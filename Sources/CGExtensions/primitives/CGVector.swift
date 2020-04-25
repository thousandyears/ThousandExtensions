extension CGVector: Real2D {
    @inlinable public var tuple: (CGFloat, CGFloat) { (dx, dy) }
    @inlinable public init(_ tuple: (CGFloat, CGFloat)) { self.init(dx: tuple.0, dy: tuple.1) }
}
