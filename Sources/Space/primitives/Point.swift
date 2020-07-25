public struct Point<D: Real>: PointInSpace {
    
    public var x: D
    public var y: D
    
    public init(x: D = 0, y: D = 0) {
        self.x = x
        self.y = y
    }
}

public protocol PointInSpace: Real2D {
    
    var x: D { get set }
    var y: D { get set }
    
    init(x: D, y: D)
}

extension PointInSpace {
    @inlinable public var tuple: (D, D) { (x, y) }
    @inlinable public init(_ tuple: (D, D)) { self.init(x: tuple.0, y: tuple.1) }
}

extension PointInSpace {
    @inlinable public func angle(to other: Self) -> D { (other - self).direction() }
    @inlinable public func distance(to other: Self) -> D { (other - self).magnitude() }
}

extension PointInSpace {
    
    @inlinable public func point<Point>(at θ: D, distance: D, as: Point.Type = Point.self) -> Point where
        Point: PointInSpace, Point.D == D
    {
        Point(x: .cos(θ), y: .sin(θ)) * distance + self
    }
}

