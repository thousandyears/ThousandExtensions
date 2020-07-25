public struct CGTransformed {
    
    public let drawing: CGDrawing
    public let transform: CGAffineTransform
    
    public init(_ drawing: CGDrawing, using transform: CGAffineTransform) {
        self.drawing = drawing
        self.transform = transform
    }
}

@inlinable public func * (lhs: CGAffineTransform, rhs: CGDrawing) -> CGTransformed {
    .init(rhs, using: lhs)
}

@inlinable public func * (lhs: CGDrawing, rhs: CGAffineTransform) -> CGTransformed {
    .init(lhs, using: rhs)
}

extension CGDrawing {
    
    @inlinable public func rotated(by: CGFloat) -> CGTransformed {
        .init(self, using: .init(rotationAngle: by))
    }
    
    @inlinable public func scaled(to: CGFloat) -> CGTransformed {
        .init(self, using: .init(scaleX: to, y: to))
    }
    
    @inlinable public func scaled(to: CGFloat, around: CGPoint) -> CGTransformed {
        .init(self, using: .init(scale: to, around: around))
    }

    @inlinable public func scaled<Scale>(to: Scale) -> CGTransformed where Scale: Real2D, Scale.D == CGFloat {
        .init(self, using: .init(scaleX: to.tuple.0, y: to.tuple.1))
    }
    
    @inlinable public func translated<Offset>(by: Offset) -> CGTransformed where Offset: Real2D, Offset.D == CGFloat {
        .init(self, using: .init(translationX: by.tuple.0, y: by.tuple.1))
    }
    
    @inlinable public func transformed(by: CGAffineTransform) -> CGTransformed {
        .init(self, using: by)
    }
}

extension CGTransformed: CGDrawing {
    
    @inlinable public func draw(with pencil: CGPencil) {
        pencil.draw(drawing, using: transform)
    }
    
    @inlinable public var debugDescription: String {
        "\(CGTransformed.self)(drawing: \(drawing), transform: \(transform))"
    }
}
