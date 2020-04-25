extension CGAffineTransform {
    
    @inlinable public init(scale: CGFloat, around p: CGPoint) {
        self = CGAffineTransform(translationX: p.x, y: p.y)
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: -p.x, y: -p.y)
    }
    
    @inlinable public init(rotateBy angle: CGFloat, around p: CGPoint) {
        self = CGAffineTransform(translationX: p.x, y: p.y)
            .rotated(by: angle)
            .translatedBy(x: -p.x, y: -p.y)
    }
}

extension CGAffineTransform {
    @inlinable public func transform(_ point: CGPoint) -> CGPoint { point.applying(self) }
    @inlinable public func transform(_ size: CGSize) -> CGSize { size.applying(self) }
    @inlinable public func transform(_ rect: CGRect) -> CGRect { rect.applying(self) }
}

extension CGAffineTransform {
    @inlinable public func transform<Points>(_ points: Points) -> [CGPoint]
        where Points: Sequence, Points.Element == CGPoint
    {
        points.applying(self)
    }
}

extension Sequence where Element == CGPoint {
    public func applying(_ t: CGAffineTransform) -> [CGPoint] {
        map{ $0.applying(t) }
    }
}
