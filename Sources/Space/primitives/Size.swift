public struct Size<D: Real>: SizeInSpace {
    
    public var width: D
    public var height: D
    
    public init(width: D = 0, height: D = 0) {
        self.width = width
        self.height = height
    }
}

public protocol SizeInSpace: Real2D {
    
    var width: D { get set }
    var height: D { get set }
    
    init(width: D, height: D)
}

extension SizeInSpace {
    @inlinable public var tuple: (D, D) { (width, height) }
    @inlinable public init(_ tuple: (D, D)) { self.init(width: tuple.0, height: tuple.1) }
}

extension SizeInSpace {
    @inlinable public init(square length: D) { self.init(width: length, height: length) }
}

extension SizeInSpace {
    @inlinable public var area: D { width * height }
}

extension SizeInSpace where D: BinaryFloatingPoint, D.RawSignificand: FixedWidthInteger {
    
    @inlinable public func randomPoint<Point>(_ type: Point.Type = Point.self) -> Point
        where Point: PointInSpace, Point.D == D
    {
        Point(
            x: .random(in: width < 0 ? width ... 0 : 0 ... width),
            y: .random(in: height < 0 ? height ... 0 : 0 ... height)
        )
    }
}

