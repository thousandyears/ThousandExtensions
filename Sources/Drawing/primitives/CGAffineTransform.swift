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
    
    @inlinable public static func translation<Offset>(by offset: Offset) -> CGAffineTransform where Offset: Real2D, Offset.D == CGFloat {
        self.init(translationX: offset.tuple.0, y: offset.tuple.1)
    }
}

extension CGAffineTransform {
    
    @inlinable public func scaled(by scale: CGFloat) -> CGAffineTransform {
        self.scaledBy(x: scale, y: scale)
    }
    
    @inlinable public func scaled(by x: CGFloat, _ y: CGFloat) -> CGAffineTransform {
        self.scaledBy(x: x, y: y)
    }

    @inlinable public func scaled<Scale: Real2D>(by scale: Scale) -> CGAffineTransform where Scale.D == CGFloat {
        self.scaledBy(x: scale.tuple.0, y: scale.tuple.1)
    }
}

extension CGAffineTransform {
    
    @inlinable public func translated(by x: CGFloat, _ y: CGFloat) -> CGAffineTransform {
        self.translatedBy(x: x, y: y)
    }

    @inlinable public func translated<Scale: Real2D>(by scale: Scale) -> CGAffineTransform where Scale.D == CGFloat {
        self.translatedBy(x: scale.tuple.0, y: scale.tuple.1)
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
