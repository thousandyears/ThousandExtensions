public struct CGPolygonalChain: Codable, Equatable {
    
    public var vertices: [CGPoint]
    public var isClosed: Bool
    
    public init<Points>(vertices: Points, closed: Bool = false)
        where Points: Sequence, Points.Element == CGPoint
    {
        self.vertices = Array(vertices)
        self.isClosed = closed
    }
}

extension CGPolygonalChain {
    @inlinable
    public init(vertices first: CGPoint, rest: CGPoint..., closed: Bool = false) {
        self.init(vertices: [first] + rest, closed: closed)
    }
}

extension CGPolygonalChain: ExpressibleByArrayLiteral {
    @inlinable
    public init(arrayLiteral elements: CGPoint...) {
        self.init(vertices: elements)
    }
}

extension CGPolygonalChain: RangeReplaceableCollection, RandomAccessCollection {
    @inlinable public var startIndex: Int { vertices.startIndex }
    @inlinable public var endIndex: Int { vertices.endIndex }
    @inlinable public subscript(index: Int) -> CGPoint { vertices[index] }
    @inlinable public func index(after i: Int) -> Int { vertices.index(after: i) }
    @inlinable public func index(before i: Int) -> Int { vertices.index(before: i) }
    @inlinable public init() { self.init(vertices: []) }
    @inlinable public mutating func replaceSubrange<C, R>(_ subrange: R, with newElements: __owned C)
        where C: Collection, R: RangeExpression, C.Element == CGPoint, R.Bound == Int
    {
        vertices.replaceSubrange(subrange, with: newElements)
    }
}

extension CGPolygonalChain {
    
    @inlinable public func bounds() throws -> CGRect { try .init(containing: vertices) }
    
//    public func scaled(toFit size: CGSize) -> CGPolygonalChain {
//        // TODO:
//    }
    
    public func scaled(toFit frame: CGRect) -> CGPolygonalChain {
        guard let bounds = try? bounds() else { return [] }
        let scale = (frame.size / bounds.size).min
        guard scale.isFinite else { return .init(vertices: Array(repeating: frame.center, count: count), closed: isClosed) }
        let fc = frame.center, bc = bounds.center
        let vertices = self.vertices.map{ fc + ($0 - bc) * scale }
        return .init(vertices: vertices, closed: isClosed)
    }
}

extension CGPolygonalChain {
    
    /// Non-trivially expensive operatoin.
    @inlinable public func center() -> CGPoint? {
        convexHull().mean()
    }
    
    @inlinable public func mean() -> CGPoint? {
        guard let first = vertices.first else { return nil }
        return vertices.dropFirst().reduce(first, +) / count.cg
    }

    public func lines() -> [CGLine] {
        var o = zip(self, dropFirst()).map{ CGLine(from: $0, to: $1) }
        if isClosed, count > 1, let first = vertices.first, let last = vertices.last {
            o.append(CGLine(from: last, to: first))
        }
        return o
    }
    
    @inlinable public func length() -> CGFloat {
        reduce(0){ $0 + $1.magnitude() }
    }
}

extension CGPolygonalChain {
    
    public init<Points>(convexHullContaining points: Points)
        where Points: Collection, Points.Element == CGPoint
    {
        let sorted = points.sorted{ $0.x < $1.x }
        guard let first = sorted.first else { self.init(); return }
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
        self.init(vertices: vertices, closed: true)
    }
    
    @inlinable public func convexHull(containing points: CGPoint...) -> CGPolygonalChain {
        convexHull(containing: points)
    }
    
    @inlinable public func convexHull<Points>(containing points: Points) -> CGPolygonalChain
        where Points: Collection, Points.Element == CGPoint
    {
        .init(convexHullContaining: vertices + points)
    }
}
