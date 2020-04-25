extension CGPoint: PointInSpace {
    public typealias D = CGFloat
}

extension CGPoint {
    @inlinable public func circle(radius: CGFloat) -> CGCircle { .init(center: self, radius: radius) }
    @inlinable public func dot(radius: CGFloat = 1) -> CGCircle { circle(radius: radius) }
}

extension CGPoint {
    
    public mutating func apply(_ t: CGAffineTransform) {
        self = self.applying(t)
    }
}

extension Sequence where Element == CGPoint {
    
    @inlinable public func dots(radius: CGFloat = 1) -> [CGCircle] {
        map{ $0.dot(radius: radius) }
    }
}

