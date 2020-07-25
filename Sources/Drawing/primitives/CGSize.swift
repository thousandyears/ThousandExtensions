extension CGSize: Real2D {
    @inlinable public var tuple: (CGFloat, CGFloat) { (width, height) }
    @inlinable public init(_ tuple: (CGFloat, CGFloat)) { self.init(width: tuple.0, height: tuple.1) }
}

extension CGSize {
    @inlinable public init(square length: CGFloat) { self.init(width: length, height: length) }
}

extension CGSize {
    @inlinable public var area: CGFloat { width * height }
    @inlinable public var isSquare: Bool { width.abs == height.abs }
    @inlinable public var isVertical: Bool { width.abs < height.abs }
    @inlinable public var isHorizontal: Bool { width.abs > height.abs }
}

extension CGSize {
    @inlinable public func scaled(toFit other: CGSize) -> CGSize { self * scale(toFit: other) }
    @inlinable public func scale(toFit other: CGSize) -> CGFloat { (other / self).min }
}

extension CGSize {
    @inlinable public func rectangle(center: CGPoint) -> CGRect { .init(center: center, size: self) }
    @inlinable public func rectangle(origin: CGPoint) -> CGRect { .init(origin: origin, size: self) }
}

extension CGSize {
    
    @inlinable public func randomPoint() -> CGPoint {
        .init(
            x: .random(in: width < 0 ? width ... 0 : 0 ... width),
            y: .random(in: height < 0 ? height ... 0 : 0 ... height)
        )
    }
}
