public struct CGStroke: Equatable, Codable {
    public var start: CGPoint
    public var elements: [Element]
    public var isClosed: Bool
}

extension CGStroke {
    
    public enum Element: Equatable {
        case l(CGPoint)                   // Line
        case q(CGPoint, CGPoint)          // Quadratic Bézier Curve
        case c(CGPoint, CGPoint, CGPoint) // Cubic Bézier Curve
    }
}

extension CGStroke {
    
    public static let zero: CGStroke = .init(start: .zero)
    public static let unit: CGStroke = .init(start: .zero, .l(.unit))
}

extension CGStroke {
    
    public init<Elements>(start: CGPoint, elements: Elements, closed: Bool = false)
        where Elements: Sequence, Elements.Element == Element
    {
        self.start = start
        self.elements = Array(elements)
        self.isClosed = closed
    }
    
    @inlinable public init(start: CGPoint, _ elements: Element..., close: Bool = false) {
        self.init(start: start, elements: elements, closed: close)
    }
}

extension CGStroke.Element: Codable {
    
    public enum Error: String, Swift.Error {
        case unexpectedPointsCount
    }

    public var points: [CGPoint] {
        switch self {
        case let .l(p): return [p]
        case let .q(p0, p1): return [p0, p1]
        case let .c(p0, p1, p2): return [p0, p1, p2]
        }
    }
    
    public init(_ points: [CGPoint]) throws {
        switch points.count {
        case 1: self = .l(points[0])
        case 2: self = .q(points[0], points[1])
        case 3: self = .c(points[0], points[1], points[2])
        default: throw Error.unexpectedPointsCount
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        try points.encode(to: encoder)
    }
    
    public init(from decoder: Decoder) throws {
        try self.init(.init(from: decoder))
    }
}

extension CGMutablePath {
    
    @inline(__always)
    public func add(_ stroke: CGStroke) {
        move(to: stroke.start, transform: .identity)
        for e in stroke.elements {
            switch e {
            case let .l(p): addLine(to: p)
            case let .q(p0, p1): addQuadCurve(to: p0, control: p1)
            case let .c(p0, p1, p2): addCurve(to: p0, control1: p1, control2: p2)
            }
        }
        if stroke.isClosed { closeSubpath() }
    }
    
    public func add<Strokes>(_ strokes: Strokes)
        where Strokes: Sequence, Strokes.Element == CGStroke
    {
        strokes.forEach(add)
    }
}

extension CGPath {
    
    public func with(_ stroke: CGStroke) -> CGPath {
        let o = mutableCopy()
        o?.add(stroke)
        guard let p = o else {
            "⚠️ Failed".peek()
            return CGMutablePath()
        }
        return p
    }
    
    public func with<Strokes>(_ strokes: Strokes) -> CGPath
        where Strokes: Sequence, Strokes.Element == CGStroke
    {
        let o = mutableCopy()
        o?.add(strokes)
        guard let p = o else {
            "⚠️ Failed".peek()
            return CGMutablePath()
        }
        return p
    }

    public func strokes() -> [CGStroke] {
        var strokes: [CGStroke] = []
        var stroke: CGStroke?
        applyWithBlock { element in
            let p = element.pointee.points
            switch element.pointee.type
            {
            case .moveToPoint:
                if let stroke = stroke { strokes.append(stroke) }
                stroke = CGStroke(start: p[0])
                
            case .addLineToPoint:
                if stroke == nil { stroke = .zero }
                stroke?.elements.append(.l(p[0]))
                
            case .addQuadCurveToPoint:
                if stroke == nil { stroke = .zero }
                stroke?.elements.append(.q(p[1], p[0]))
                
            case .addCurveToPoint:
                if stroke == nil { stroke = .zero }
                stroke?.elements.append(.c(p[2], p[0], p[1]))

            case .closeSubpath:
                if stroke == nil { stroke = .zero }
                stroke?.isClosed = true
                if let stroke = stroke { strokes.append(stroke) }
                stroke = nil
                
            @unknown default:
                assert(false, "The new case \(element.pointee.type) is not handled")
                break
            }
        }
        if let stroke = stroke { strokes.append(stroke) }
        return strokes
    }
}
