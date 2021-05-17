public struct LineSegment<Point: PointInSpace>: LineSegmentInSpace {
    
    public var start: Point
    public var end: Point
    
    public init(from start: Point = .zero, to end: Point = .zero) {
        self.start = start
        self.end = end
    }
}

public protocol LineSegmentInSpace {
    
    associatedtype Point: PointInSpace
    
    var start: Point { get set }
    var end: Point { get set }
    
    init(from start: Point, to end: Point)
}

extension LineSegmentInSpace {
    public typealias D = Point.D
}

extension LineSegmentInSpace {
    
    public init(at point: Point, direction: D, anchor: D, length: D) {
        self.init(
            from: point.point(at: direction - .pi, distance: length * anchor),
            to: point.point(at: direction, distance: length * (1 - anchor))
        )
    }
}

extension LineSegmentInSpace {
    @inlinable public func angle() -> D { start.angle(to: end) }
    @inlinable public func length() -> D { start.distance(to: end) }
    @inlinable public func slope() -> D { (end.y - start.y) / (end.x - start.x) }
    @inlinable public func xIntercept() -> D { -yIntercept() / slope() }
    @inlinable public func yIntercept() -> D { end.y - slope() * end.x }
}

extension LineSegmentInSpace {
    @inlinable public var center: Point { (start + end) / 2 }
}

extension LineSegmentInSpace {
    
    @inlinable public func points(count: Int) -> [Point] {
        switch count
        {
        case 1:
            return [center]
        
        case 2:
            return [start, end]
            
        case 3...:
            var o: [Point] = [start]
            o.reserveCapacity(count)
            let d = (end - start) / D(count - 1)
            for i in 1 ..< (count - 1) { o.append(start + d * D(i)) }
            o.append(end)
            return o

        default: return []
        }
    }
}

extension LineSegmentInSpace {
    
    public func intersection<Point, Line>(with other: Line, as: Point.Type = Point.self) -> Point?
        where Point: PointInSpace, Point.D == D, Line: LineSegmentInSpace, Line.D == D
    {
        let (a, b, c, d) = (slope(), yIntercept(), other.slope(), other.yIntercept())
        let x: D, s: D, i: D
        switch (a.isFinite, c.isFinite) {
        case (false, false): return nil
        case (true, true): (x, s, i) = ((d - b) / (a - c), a, b)
        case (false, true): (x, s, i) = (start.x, c, d)
        case (true, false): (x, s, i) = (other.start.x, a, b)
        }
        let y = s * x + i
        guard
            x.isFinite, y.isFinite,
            x.isBetween(start.x, and: end.x),
            y.isBetween(start.y, and: end.y),
            x.isBetween(other.start.x, and: other.end.x),
            y.isBetween(other.start.y, and: other.end.y)
            else
        { return nil }
        return .init(x: x, y: y)
    }
}

