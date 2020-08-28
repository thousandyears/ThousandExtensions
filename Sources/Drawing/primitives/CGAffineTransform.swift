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
    
    @inlinable public init(translationBy vector: CGVector) {
        self.init(translationX: vector.dx, y: vector.dy)
    }
}

extension CGAffineTransform {
    @inlinable public var scale: CGSize { .init(width: a, height: d) }
    @inlinable public var translation: CGVector { .init(dx: tx, dy: ty) }
}

extension CGAffineTransform {
    
    @inlinable public func apply(to size: CGSize) -> CGSize { size.applying(self) }
    @inlinable public func apply(to rect: CGRect) -> CGRect { rect.applying(self) }
    @inlinable public func apply(to point: CGPoint) -> CGPoint { point.applying(self) }
    
    @inlinable public func apply<Points>(to points: Points) -> [CGPoint]
        where Points: Sequence, Points.Element == CGPoint // TODO: Points.Element: Real2D
    {
        points.map{ $0.applying(self) }
    }
}

extension Sequence where Element == CGPoint { // TODO: Element: Real2D
    
    public func applying(_ t: CGAffineTransform) -> [CGPoint] {
        map{ $0.applying(t) }
    }
}
