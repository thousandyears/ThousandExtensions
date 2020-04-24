extension Sequence {
    public static func * (l: Self, r: Int) -> FlattenSequence<Repeated<Self>> {
        repeatElement(l, count: r).joined()
    }
}

extension Sequence where Element: Hashable {
    
    public var set: Set<Element> { .init(self) }
}

extension Sequence {
    
    @inline(__always) public var array: Array<Element> { .init(self) }

    @inline(__always) public func first<T>(_: T.Type = T.self) -> T? {
        first(where: { $0 is T }) as? T
    }
    
    @inline(__always) public func filter<T>(_: T.Type = T.self) -> [T] {
        compactMap{ $0 as? T }
    }
    
    @inline(__always) public func except<T>(_: T.Type = T.self) -> [Element] {
        except{ $0 is T }
    }
    
    @inline(__always) public func except(_ isNotIncluded: (Element) throws -> Bool) rethrows -> [Element] {
        try filter{ try !isNotIncluded($0) }
    }
}

extension Sequence {

    @inlinable public func compactFirst<ElementOfResult>(
        _ transform: (Self.Element) throws -> ElementOfResult?
    ) rethrows -> ElementOfResult? {
        for e in self {
            if let o = try transform(e) {
                return o
            }
        }
        return nil
    }
}

extension Collection {
    
    @inlinable public var ifNotEmpty: Self? { isEmpty ? nil : self }

    @inlinable public func at(_ index: Index) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}

extension Collection where Element: ExpressibleByArrayLiteral { // TODO: generalize further
    
    @inlinable public func reduce(_ nextPartialResult: (Element, Element) throws -> Element) rethrows -> Element {
        guard let first = first else { return [] }
        return try dropFirst().reduce(first, nextPartialResult)
    }
}

extension Collection where Element: ExpressibleByDictionaryLiteral { // TODO: generalize further
    
    @inlinable public func reduce(_ nextPartialResult: (Element, Element) throws -> Element) rethrows -> Element {
        guard let first = first else { return [:] }
        return try dropFirst().reduce(first, nextPartialResult)
    }
}
