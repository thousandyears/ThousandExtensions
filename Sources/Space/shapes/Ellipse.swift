public protocol EllipseSpace {
    associatedtype Point: PointInSpace where Self.Point.D == Self
}

extension EllipseSpace where Self: Real {
    public typealias Point = Space.Point<Self>
}

extension Float: EllipseSpace {}
extension Double: EllipseSpace {}

public struct Ellipse<In: EllipseSpace>: EllipseInSpace {
    
    public typealias D = In
    public typealias Point = In.Point
    
    public var center: Point
    public var radius: (x: D, y: D)
    
    public init(center: Point = .zero, radius: (x: D, y: D) = (0, 0)) {
        self.center = center
        self.radius = radius
    }
}

public protocol EllipseInSpace {
    
    associatedtype D
    associatedtype Point: PointInSpace where Point.D == D
    
    var center: Point { get set }
    var radius: (x: D, y: D) { get set }
    
    init(center: Point, radius: (x: D, y: D))
}

extension EllipseInSpace where D: BinaryFloatingPoint {
    
    @inlinable public func cast<Other>(to: Other.Type = Other.self) -> Other where Other: EllipseInSpace, Other.D: BinaryFloatingPoint {
        let (rx, ry) = radius
        return .init(center: center.cast(), radius: (rx.cast(), ry.cast()))
    }
}

extension EllipseInSpace {
    
    @inlinable public func size<A>() -> A where A: SizeInSpace, A.D == D {
        A(width: radius.x * 2, height: radius.y * 2)
    }
}

