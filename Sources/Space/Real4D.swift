public protocol Real4D: Equatable {
    associatedtype D: Real
    var tuple: (D, D, D, D) { get }
    init(_: (D, D, D, D)) // TODO: rethink this - it can only be satisfyied by required init in nonfinal classes
}

@inlinable public func + <X: Real>(l: (X, X, X, X), r: X) -> (X, X, X, X) { apply(+, to: l, and: r) }
@inlinable public func - <X: Real>(l: (X, X, X, X), r: X) -> (X, X, X, X) { apply(-, to: l, and: r) }
@inlinable public func * <X: Real>(l: (X, X, X, X), r: X) -> (X, X, X, X) { apply(*, to: l, and: r) }
@inlinable public func / <X: Real>(l: (X, X, X, X), r: X) -> (X, X, X, X) { apply(/, to: l, and: r) }

@inlinable public func apply<X, Y>(_ ƒ: (X, X) -> Y, to l: (X, X, X, X), and r: X) -> (Y, Y, Y, Y) {
    (ƒ(l.0, r), ƒ(l.1, r), ƒ(l.2, r), ƒ(l.3, r))
}

@inlinable public func + <X: Real>(l: (X, X, X, X), r: (X, X, X, X)) -> (X, X, X, X) { apply(+, to: l, and: r) }
@inlinable public func - <X: Real>(l: (X, X, X, X), r: (X, X, X, X)) -> (X, X, X, X) { apply(-, to: l, and: r) }
@inlinable public func * <X: Real>(l: (X, X, X, X), r: (X, X, X, X)) -> (X, X, X, X) { apply(*, to: l, and: r) }
@inlinable public func / <X: Real>(l: (X, X, X, X), r: (X, X, X, X)) -> (X, X, X, X) { apply(/, to: l, and: r) }

@inlinable public func apply<X, Y>(_ ƒ: (X, X) -> Y, to l: (X, X, X, X), and r: (X, X, X, X)) -> (Y, Y, Y, Y) {
    (ƒ(l.0, r.0), ƒ(l.1, r.1), ƒ(l.2, r.2), ƒ(l.3, r.3))
}
