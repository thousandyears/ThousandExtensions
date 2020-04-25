public struct CGEllipse: EllipseInSpace, Codable, Equatable {
    
    public var center: CGPoint
    public var xRadius: CGFloat
    public var yRadius: CGFloat
    
    public init(center: CGPoint = .zero, xRadius: CGFloat = 0, yRadius: CGFloat = 0) {
        self.center = center
        self.xRadius = xRadius
        self.yRadius = yRadius
    }
}

extension CGEllipse {
    
    public static let zero = CGEllipse()
    public static let unit = CGEllipse(xRadius: 1, yRadius: 1)
    
    public init(center: CGPoint = .zero, size: CGSize) {
        self.center = center
        self.xRadius = size.width / 2
        self.yRadius = size.height / 2
    }
    
    public init(frame: CGRect) {
        self.init(center: frame.center, size: frame.size)
    }
}

extension CGEllipse {

    @inlinable public var size: CGSize {
        get{ CGSize(width: xDiameter, height: yDiameter) }
        set{ (xRadius, yRadius) = (newValue / 2).tuple }
    }

    @inlinable public var frame: CGRect {
        get{ .init(center: center, size: size) }
        set{ (center, size) = (newValue.center, newValue.size) }
    }
}

extension CGEllipse {

    @inlinable public func point(at angle: CGFloat) -> CGPoint {
        CGPoint(
            x: center.x + xRadius * angle.cos(),
            y: center.y + yRadius * angle.sin()
        )
    }

    @inlinable public func points(count: Int) -> [CGPoint] {
        guard count > 0 else { return [] }
        return (0..<count).map{ point(at: 2 * $0.π / count.cg) }
    }
}
