public enum CGLength {
    
    /// Absolute:
    case pt(CGFloat)
    
    /// Relative to 1% of viewport:
    case vw(CGFloat)
    case vh(CGFloat)
    case vmin(CGFloat)
    case vmax(CGFloat)
    
    /// Relative to 1% of parent:
    case pw(CGFloat)
    case ph(CGFloat)
    case pmin(CGFloat)
    case pmax(CGFloat)
}

extension BinaryInteger {
    
    @inlinable public var pt: CGLength { .pt(cg) }

    @inlinable public var vw: CGLength { .vw(cg) }
    @inlinable public var vh: CGLength { .vh(cg) }
    @inlinable public var vmin: CGLength { .vmin(cg) }
    @inlinable public var vmax: CGLength { .vmax(cg) }

    @inlinable public var pw: CGLength { .pw(cg) }
    @inlinable public var ph: CGLength { .ph(cg) }
    @inlinable public var pmin: CGLength { .pmin(cg) }
    @inlinable public var pmax: CGLength { .pmax(cg) }
}

extension BinaryFloatingPoint {
    
    @inlinable public var pt: CGLength { .pt(cg) }

    @inlinable public var vw: CGLength { .vw(cg) }
    @inlinable public var vh: CGLength { .vh(cg) }
    @inlinable public var vmin: CGLength { .vmin(cg) }
    @inlinable public var vmax: CGLength { .vmax(cg) }

    @inlinable public var pw: CGLength { .pw(cg) }
    @inlinable public var ph: CGLength { .ph(cg) }
    @inlinable public var pmin: CGLength { .pmin(cg) }
    @inlinable public var pmax: CGLength { .pmax(cg) }
}

extension CGLength {
    
    @inlinable public func `in`(_ frame: CGRect) -> CGFloat {
        self.in(parent: frame, screen: frame)
    }
    
    public func `in`(parent: CGRect, screen: CGRect) -> CGFloat {
        switch self
        {
        case let .pt(o): return o
            
        case let .vw(o): return screen.width * o / 100
        case let .vh(o): return screen.height * o / 100
        case let .vmin(o): return screen.size.min * o / 100
        case let .vmax(o): return screen.size.max * o / 100
            
        case let .pw(o): return parent.width * o / 100
        case let .ph(o): return parent.height * o / 100
        case let .pmin(o): return parent.size.min * o / 100
        case let .pmax(o): return parent.size.max * o / 100
        }
    }
}

extension CGLength {
    
    @inlinable public func map(_ ƒ: (CGFloat) throws -> CGFloat) rethrows -> CGLength {
        switch self
        {
        case let .pt(o): return try .pt(ƒ(o))
            
        case let .vw(o): return try .vw(ƒ(o))
        case let .vh(o): return try .vh(ƒ(o))
        case let .vmin(o): return try .vmin(ƒ(o))
        case let .vmax(o): return try .vmax(ƒ(o))
            
        case let .pw(o): return try .pw(ƒ(o))
        case let .ph(o): return try .ph(ƒ(o))
        case let .pmin(o): return try .pmin(ƒ(o))
        case let .pmax(o): return try .pmax(ƒ(o))
        }
    }

    @inlinable public static func + <X: BinaryFloatingPoint>(lhs: CGLength, rhs: X) -> CGLength {
        lhs.map{ $0 + rhs.cg }
    }
    @inlinable public static func - <X: BinaryFloatingPoint>(lhs: CGLength, rhs: X) -> CGLength {
        lhs.map{ $0 - rhs.cg }
    }
    @inlinable public static func * <X: BinaryFloatingPoint>(lhs: CGLength, rhs: X) -> CGLength {
        lhs.map{ $0 * rhs.cg }
    }
    @inlinable public static func / <X: BinaryFloatingPoint>(lhs: CGLength, rhs: X) -> CGLength {
        lhs.map{ $0 / rhs.cg }
    }

    @inlinable public static func + <X: BinaryInteger>(lhs: CGLength, rhs: X) -> CGLength {
        lhs.map{ $0 + rhs.cg }
    }
    @inlinable public static func - <X: BinaryInteger>(lhs: CGLength, rhs: X) -> CGLength {
        lhs.map{ $0 - rhs.cg }
    }
    @inlinable public static func * <X: BinaryInteger>(lhs: CGLength, rhs: X) -> CGLength {
        lhs.map{ $0 * rhs.cg }
    }
    @inlinable public static func / <X: BinaryInteger>(lhs: CGLength, rhs: X) -> CGLength {
        lhs.map{ $0 / rhs.cg }
    }

    @inlinable public static func += <X: BinaryFloatingPoint>(lhs: inout CGLength, rhs: X) {
        lhs = lhs.map{ $0 + rhs.cg }
    }
    @inlinable public static func -= <X: BinaryFloatingPoint>(lhs: inout CGLength, rhs: X) {
        lhs = lhs.map{ $0 - rhs.cg }
    }
    @inlinable public static func *= <X: BinaryFloatingPoint>(lhs: inout CGLength, rhs: X) {
        lhs = lhs.map{ $0 * rhs.cg }
    }
    @inlinable public static func /= <X: BinaryFloatingPoint>(lhs: inout CGLength, rhs: X) {
        lhs = lhs.map{ $0 / rhs.cg }
    }

    @inlinable public static func += <X: BinaryInteger>(lhs: inout CGLength, rhs: X) {
        lhs = lhs.map{ $0 + rhs.cg }
    }
    @inlinable public static func -= <X: BinaryInteger>(lhs: inout CGLength, rhs: X) {
        lhs = lhs.map{ $0 - rhs.cg }
    }
    @inlinable public static func *= <X: BinaryInteger>(lhs: inout CGLength, rhs: X) {
        lhs = lhs.map{ $0 * rhs.cg }
    }
    @inlinable public static func /= <X: BinaryInteger>(lhs: inout CGLength, rhs: X) {
        lhs = lhs.map{ $0 / rhs.cg }
    }
}
