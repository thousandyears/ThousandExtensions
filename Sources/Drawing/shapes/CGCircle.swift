public struct CGCircle: Codable, Equatable {
    
    public var center: CGPoint
    public var radius: CGFloat
    
    public init(center: CGPoint = .zero, radius: CGFloat = 0) {
        self.center = center
        self.radius = radius
    }
}

extension CGCircle {
    public static let zero = CGCircle(center: .zero, radius: 0)
    public static let unit = CGCircle(center: .zero, radius: 1)
}

extension CGCircle {
    
    public init(center: (x: CGFloat, y: CGFloat), radius: CGFloat) {
        self.center = .init(center)
        self.radius = radius
    }
}

extension CGCircle {
    @inlinable public var diameter: CGFloat { radius * 2 }
    @inlinable public var size: CGSize { .init(square: radius * 2) }
    @inlinable public var frame: CGRect { .init(center: center, size: size) }
    @inlinable public var ellipse: CGEllipse { .init(center: center, radius: (radius, radius)) }
}

extension CGCircle {
    
    @inlinable public func scaled(to scale: CGFloat) -> CGCircle {
        .init(center: center, radius: radius * scale)
    }
    
    @inlinable public func resized(by diameterDifference: CGFloat) -> CGCircle {
        .init(center: center, radius: radius - diameterDifference / 2)
    }

    @inlinable public func contains(_ point: CGPoint) -> Bool {
        point.distance(to: center) <= radius
    }
    
    @inlinable public func point(at angle: CGFloat) -> CGPoint {
        .init(x: .cos(angle), y: .sin(angle)) * radius + center
    }
    
    @inlinable public func points(count: Int, startingFrom angle: CGFloat = 0) -> [CGPoint] {
        count > 0 ? stride(from: angle, to: angle + 2.π, by: 2.π / count.cg).prefix(count).map{ point(at: $0) } : []
    }
    
    @inlinable public func randomPoint(in range: ClosedRange<CGFloat> = 0 ± 1.π) -> CGPoint {
        point(at: .random(in: range))
    }
}

extension CGCircle: CGDrawing {
    
    @inlinable public func draw(with pencil: CGPencil) {
        pencil.draw(ellipse)
    }
    
    @inlinable public var debugDescription: String {
        "\(CGCircle.self)(center: \(center), radius: \(radius))"
    }
}
