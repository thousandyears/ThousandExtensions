extension Sequence where Element: PointInSpace {
    
    public typealias Point = Element
    
    public func mean() -> Point? {
        var ºsum: Point?
        var count = 0
        for e in self {
            count += 1
            if let a = ºsum { ºsum = a + e }
            else { ºsum = e }
        }
        guard let sum = ºsum else { return nil }
        return sum / Point.D(count)
    }

    public func convexHull() -> [Point] {
        let sorted = self.sorted{ $0.x < $1.x }
        guard let first = sorted.first else { return [] }
        var current = first
        var vertices = [current]
        while
            let next = sorted.min(by: {
                $1 == current
                || $0.crossProduct(with: $1, relativeTo: current) < 0
            }),
            next != first
        {
            vertices.append(next)
            current = next
        }
        return vertices
    }
    
    public func lineSegments<Line>(closed: Bool, as: [Line].Type = [Line].self) -> [Line]
        where Line: LineSegmentInSpace, Line.Point == Point
    {
        var ºfirst: Point?
        var ºlast: Point?
        var lines: [Line] = []
        for point in self {
            if ºfirst == nil {
                ºfirst = point
            } else if let last = ºlast {
                 lines.append(Line(from: last, to: point))
            }
            ºlast = point
        }
        guard let first = ºfirst, let last = ºlast, !lines.isEmpty else { return [] }
        if closed { lines.append(Line(from: last, to: first) ) }
        return lines
    }
}
