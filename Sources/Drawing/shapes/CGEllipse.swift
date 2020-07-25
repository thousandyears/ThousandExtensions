public struct CGEllipse: Codable, Equatable {

    public var center: CGPoint
    public var xRadius: CGFloat
    public var yRadius: CGFloat
    
    public init(center: CGPoint = .zero, radius: (x: CGFloat, y: CGFloat) = (0, 0)) {
        self.center = center
        (xRadius, yRadius) = radius
    }
}

extension CGEllipse {
    
    @inlinable public var radius: (x: CGFloat, y: CGFloat) {
        get { (xRadius, yRadius) }
        set { (xRadius, yRadius) = newValue }
    }
}

extension CGEllipse {
    
    public static let zero = CGEllipse()
    public static let unit = CGEllipse(radius: (1, 1))
    
    public init(center: CGPoint = .zero, size: CGSize) {
        self.center = center
        self.xRadius = size.width / 2
        self.yRadius = size.height / 2
    }
    
    public init(center: (x: CGFloat, y: CGFloat), radius: (x: CGFloat, y: CGFloat)) {
        self.center = .init(center)
        self.xRadius = radius.x
        self.yRadius = radius.y
    }

    public init(frame: CGRect) {
        self.init(center: frame.center, size: frame.size)
    }
}

extension CGEllipse {

    @inlinable public var size: CGSize {
        get{ CGSize(radius) * 2 }
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
            x: center.x + xRadius * cos(angle),
            y: center.y + yRadius * sin(angle)
        )
    }

    @inlinable public func points(count: Int) -> [CGPoint] {
        guard count > 0 else { return [] }
        return (0..<count).map{ point(at: 2 * $0.π / count.cg) }
    }
}

extension CGEllipse: CGDrawing {
    
    @inlinable public func draw(with pencil: CGPencil) {
        pencil.draw(self)
    }
    
    @inlinable public var debugDescription: String {
        "\(CGEllipse.self)(center: \(center), radius: \(radius))"
    }
}
