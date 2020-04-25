import SwiftExtensions

extension CGRect {
    
    public static let unit: CGRect = .init(origin: .zero, size: .unit)
}

extension CGRect {
    
    @inlinable public init(center: CGPoint, size: CGSize) {
        self.init(
            origin: center - size / 2,
            size: size
        )
    }
    
    @inlinable public init(size: CGSize) {
        self.init(
            center: .zero,
            size: size
        )
    }
    
    @inlinable public init(width: CGFloat, height: CGFloat) {
        self.init(
            center: .zero,
            size: .init(width: width, height: height)
        )
    }
}

extension CGRect {
    @inlinable public var center: CGPoint { origin + size / 2 }
    @inlinable public var incircle: CGCircle { .init(center: center, radius: size.min / 2) } // TODO: alignment optioin
    @inlinable public var inellipse: CGEllipse { .init(center: center, xRadius: width / 2, yRadius: height / 2) }
}

extension CGRect {
    @inlinable public var xAxis: CGLine { .init(from: .init(x: minX, y: midY), to: .init(x: maxX, y: midY)) }
    @inlinable public var yAxis: CGLine { .init(from: .init(x: midX, y: minY), to: .init(x: midX, y: maxY)) }
}

extension CGRect {
    
    public func padded(by padding: CGFloat) -> CGRect { // TODO: use a dedicated offsets type
        .init(origin: origin - padding, size: size + 2 * padding)
    }
}

extension CGRect {
    
    @inlinable public func transform(to other: CGRect) -> CGAffineTransform {
        CGAffineTransform(translationX: other.origin.x, y: other.origin.y)
            .scaledBy(x: other.width / width, y: other.height / height)
            .translatedBy(x: -origin.x, y: -origin.y)
    }
    
    @inlinable public func translate<A>(by: A) -> CGRect where A: Real2D, A.R == CGFloat {
        applying(.init(translationX: by.tuple.0, y: by.tuple.1))
    }
    
    @inlinable public func scaled<A>(to: CGFloat, anchor: A) -> CGRect where A: Real2D, A.R == CGFloat {
        applying(.init(scale: to, around: point(at: anchor)))
    }
    
    @inlinable public func scaled(to: CGFloat) -> CGRect {
        scaled(to: to, anchor: CGPoint.unit / 2)
    }
}

extension CGRect {
    
    @inlinable public func point<A>(at anchor: A) -> CGPoint where A: Real2D, A.R == CGFloat {
        (size * anchor + origin).cast()
    }
}

extension CGRect {
    @inlinable public func randomPoint() -> CGPoint { size.randomPoint() + origin }
}

extension CGRect {
    
    public init<Points>(containing points: Points) throws
        where Points: Collection, Points.Element == CGPoint
    {
        let first = try points.first.or(throw: "Cannot calculate the bounds of an set of points".error())
        var (min, max) = (first, first)
        for p in points {
            if p.x < min.x { min.x = p.x }
            else if p.x > max.x { max.x = p.x }
            if p.y < min.y { min.y = p.y }
            else if p.y > max.y { max.y = p.y }
        }
        self.init(x: min.x, y: min.y, width: max.x - min.x, height: max.y - min.y)
    }
}

extension CGRect {
    
    public func tiles(rows: Int, cols: Int) throws -> UnfoldSequence<CGRect, Int> {
        guard rows > 0 else { throw "Expected rows > 0, got: \(rows)".error() }
        guard cols >= 0 else { throw "Expected cols >=0, got: \(cols)".error() }
        return sequence(state: 0){ i in
            defer { i += 1 }
            guard i < rows * cols else { return nil }
            return try? self.tileAt(index: i, ofRows: rows, cols: cols)
        }
    }

    public func tileAt(
        index: Int,
        ofRows rows: Int,
        cols: Int
    ) throws -> CGRect {
        guard index >= 0 else { throw "Expected index >= 0, got: \(index)".error() }
        guard rows > 0 else { throw "Expected rows > 0, got: \(rows)".error() }
        guard cols >= 0 else { throw "Expected cols >=0, got: \(cols)".error() }
        guard index < rows * cols else { throw "Expected index < rows * cols, got index: \(index), rows: \(rows), cols: \(cols)".error() }
        return try tileAt(
            row: index / cols,
            of: rows,
            col: index % cols,
            of: cols
        )
    }

    public func tileAt(
        row: Int, of rows: Int,
        col: Int, of cols: Int
    ) throws -> CGRect {
        guard row >= 0 else { throw "Expected row >= 0, got: \(row)".error() }
        guard rows > 0 else { throw "Expected rows > 0, got: \(rows)".error() }
        guard col >= 0 else { throw "Expected col >= 0, got: \(col)".error() }
        guard cols >= 0 else { throw "Expected cols >=0, got: \(cols)".error() }
        let size = CGSize(
            width: width / cols.cg,
            height: height / rows.cg
        )
        return CGRect(
            origin: origin + size * CGPoint(x: col.cg, y: row.cg),
            size: size
        )
    }
}
