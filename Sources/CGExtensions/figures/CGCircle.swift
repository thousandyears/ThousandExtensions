public struct CGCircle: CircleInSpace, Codable, Equatable {
    
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
    @inlinable public var size: CGSize { .init(square: radius * 2) }
    @inlinable public var frame: CGRect { .init(center: center, size: size) }
}
