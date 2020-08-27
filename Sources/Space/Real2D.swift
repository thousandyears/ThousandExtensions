public protocol Real2D: Equatable, CustomDebugStringConvertible {
    
    associatedtype D: Real
    
    /// required:
    var tuple: (D, D) { get }
    init(_ tuple: (D, D))
    
    /// optional:
    var range: ClosedRange<D> { get }
    var min: D { get }
    var max: D { get }
}

extension Real2D {
    @inlinable public var range: ClosedRange<D> { min ... max }
    @inlinable public var min: D { tuple.0 < tuple.1 ? tuple.0 : tuple.1 }
    @inlinable public var max: D { tuple.0 > tuple.1 ? tuple.0 : tuple.1 }
}

extension Real2D {
    @inlinable public init<A: Real2D>(_ a: A) where A.D == D { self.init(a.tuple) }
    @inlinable public func cast<A: Real2D>(to: A.Type = A.self) -> A where A.D == D { A.init(tuple) }
}

extension Real2D {
    public static func == (l: Self, r: Self) -> Bool { l.tuple == r.tuple }
    public var debugDescription: String { "\(Self.self)(\(tuple.0), \(tuple.1))" }
}

extension Real2D {
    @inlinable public static var zero: Self { .init((0, 0)) }
    @inlinable public static var unit: Self { .init((1, 1)) }
}

extension Real2D {
    @inlinable public var isFinite: Bool { tuple.0.isFinite && tuple.1.isFinite }
    @inlinable public func rounded(toNearestMultipleOf x: D) -> Self { map{ $0.rounded(toNearestMultipleOf: x) } }
}

extension Real2D {
    @inlinable public prefix static func - (o: Self) -> Self { o.map{ -$0 } }
}

extension Real2D {
    @inlinable public static func + (l: Self, r: D) -> Self { l.map{ $0 + r } }
    @inlinable public static func - (l: Self, r: D) -> Self { l.map{ $0 - r } }
    @inlinable public static func * (l: Self, r: D) -> Self { l.map{ $0 * r } }
    @inlinable public static func / (l: Self, r: D) -> Self { l.map{ $0 / r } }
}

extension Real2D {
    @inlinable public static func += (l: inout Self, r: D) { l = l + r }
    @inlinable public static func -= (l: inout Self, r: D) { l = l - r }
    @inlinable public static func *= (l: inout Self, r: D) { l = l * r }
    @inlinable public static func /= (l: inout Self, r: D) { l = l / r }
}

extension Real2D {
    @inlinable public static func + (l: Self, r: (D, D)) -> Self { self.init( (l.tuple.0 + r.0, l.tuple.1 + r.1) ) }
    @inlinable public static func - (l: Self, r: (D, D)) -> Self { self.init( (l.tuple.0 - r.0, l.tuple.1 - r.1) ) }
    @inlinable public static func * (l: Self, r: (D, D)) -> Self { self.init( (l.tuple.0 * r.0, l.tuple.1 * r.1) ) }
    @inlinable public static func / (l: Self, r: (D, D)) -> Self { self.init( (l.tuple.0 / r.0, l.tuple.1 / r.1) ) }
}

extension Real2D {
    @inlinable public static func += (l: inout Self, r: (D, D)) { l = l + r }
    @inlinable public static func -= (l: inout Self, r: (D, D)) { l = l - r }
    @inlinable public static func *= (l: inout Self, r: (D, D)) { l = l * r }
    @inlinable public static func /= (l: inout Self, r: (D, D)) { l = l / r }
}

extension Real2D {
    @inlinable public static func + <A: Real2D>(l: Self, r: A) -> Self where A.D == D { self.init( (l.tuple.0 + r.tuple.0, l.tuple.1 + r.tuple.1) ) }
    @inlinable public static func - <A: Real2D>(l: Self, r: A) -> Self where A.D == D { self.init( (l.tuple.0 - r.tuple.0, l.tuple.1 - r.tuple.1) ) }
    @inlinable public static func * <A: Real2D>(l: Self, r: A) -> Self where A.D == D { self.init( (l.tuple.0 * r.tuple.0, l.tuple.1 * r.tuple.1) ) }
    @inlinable public static func / <A: Real2D>(l: Self, r: A) -> Self where A.D == D { self.init( (l.tuple.0 / r.tuple.0, l.tuple.1 / r.tuple.1) ) }
}

extension Real2D {
    @inlinable public static func += <A: Real2D>(l: inout Self, r: A) where A.D == D { l = l + r }
    @inlinable public static func -= <A: Real2D>(l: inout Self, r: A) where A.D == D { l = l - r }
    @inlinable public static func *= <A: Real2D>(l: inout Self, r: A) where A.D == D { l = l * r }
    @inlinable public static func /= <A: Real2D>(l: inout Self, r: A) where A.D == D { l = l / r }
}

extension Real2D {
    @inlinable public func map<T>(_ ƒ: (D) -> T) -> (T, T) { let (a, b) = tuple; return (ƒ(a), ƒ(b)) }
    @inlinable public func map(_ ƒ: (D) -> D) -> Self { let (a, b) = tuple; return Self((ƒ(a), ƒ(b))) }
    @inlinable public func sorted(_ areSorted: (D, D) -> Bool) -> Self {
        areSorted(tuple.0, tuple.1) ? self : .init((tuple.1, tuple.0))
    }
}

extension Real2D where D: BinaryFloatingPoint {
    
    @inlinable public func cast<Other>(to: Other.Type = Other.self) -> Other where Other: Real2D, Other.D: BinaryFloatingPoint {
        let (a, b) = tuple
        return Other((a.cast(), b.cast()))
    }
}

extension Real2D {
    @inlinable public var span: D { max - min }
    @inlinable public var ratio: D { tuple.0 / tuple.1 }
    @inlinable public func magnitude() -> D { D.hypot(tuple.0, tuple.1) }
    @inlinable public func direction() -> D { D.atan2(y: tuple.1, x: tuple.0) }
}

extension Real2D {
    
    @inlinable public func crossProduct<A: Real2D>(with a: A) -> D
        where A.D == D
    {
        tuple.0 * a.tuple.1 - tuple.1 * a.tuple.0
    }
    
    @inlinable public func crossProduct<A: Real2D, B: Real2D>(with a: A, relativeTo b: B) -> D
        where A.D == D, B.D == D
    {
        (self - b).crossProduct(with: a - b)
    }
}

// MARK: - 2-tuples

@inlinable public func + <D: Real>(l: (D, D), r: D) -> (D, D) { apply(+, to: l, and: r) }
@inlinable public func - <D: Real>(l: (D, D), r: D) -> (D, D) { apply(-, to: l, and: r) }
@inlinable public func * <D: Real>(l: (D, D), r: D) -> (D, D) { apply(*, to: l, and: r) }
@inlinable public func / <D: Real>(l: (D, D), r: D) -> (D, D) { apply(/, to: l, and: r) }

@inlinable public func apply<X, Y>(_ ƒ: (X, X) -> Y, to l: (X, X), and r: X) -> (Y, Y) {
    (ƒ(l.0, r), ƒ(l.1, r))
}

@inlinable public func + <D: Real>(l: (D, D), r: (D, D)) -> (D, D) { apply(+, to: l, and: r) }
@inlinable public func - <D: Real>(l: (D, D), r: (D, D)) -> (D, D) { apply(-, to: l, and: r) }
@inlinable public func * <D: Real>(l: (D, D), r: (D, D)) -> (D, D) { apply(*, to: l, and: r) }
@inlinable public func / <D: Real>(l: (D, D), r: (D, D)) -> (D, D) { apply(/, to: l, and: r) }

@inlinable public func apply<X, Y>(_ ƒ: (X, X) -> Y, to l: (X, X), and r: (X, X)) -> (Y, Y) {
    (ƒ(l.0, r.0), ƒ(l.1, r.1))
}

// MARK: - Real2DEach

extension Real2D {
    
    public var each: Real2DEach<Self> { .init(root: self) }
}

@dynamicMemberLookup
public struct Real2DEach<Root: Real2D> {
    
    public let root: Root
    
    public subscript<Property>(dynamicMember property: KeyPath<Root.D, Property>) -> (Property, Property) {
        return (root.tuple.0[keyPath: property], root.tuple.1[keyPath: property])
    }
}
