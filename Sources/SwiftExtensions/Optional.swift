extension Optional {
    
    @inlinable public func flatMap<A>(_ as: A.Type = A.self) -> A? {
        self as? A
    }

    @inlinable public func ifSome<Ignored>(_ ƒ: (Wrapped) throws -> Ignored) rethrows {
        if case let .some(wrapped) = self { _ = try ƒ(wrapped) }
    }
}

extension Optional where Wrapped: Collection {
    @inlinable public var isNilOrEmpty: Bool { self?.isEmpty ?? true }
    @inlinable public var ifNotEmpty: Self { isNilOrEmpty ? nil : self }
}
