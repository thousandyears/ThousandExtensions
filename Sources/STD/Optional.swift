extension Optional {
    
    @inlinable public func flatMap<A>(_ as: A.Type = A.self) -> A? {
        self as? A
    }
    
    @inlinable public func or(_ `default`: Wrapped) -> Wrapped {
        self ?? `default`
    }
    
    @inlinable public func or(
        _ function: StaticString = #function,
        _ file: StaticString = #file,
        _ line: Int = #line
    ) throws -> Wrapped {
        try or(throw: "⚠️".error(function, file, line))
    }
    
    @inlinable public func or(throw error: @autoclosure () -> Error) throws -> Wrapped {
        guard let o = self else { throw error() }
        return o
    }

    @inlinable public func ifSome<Ignored>(_ ƒ: (Wrapped) throws -> Ignored) rethrows {
        if case let .some(wrapped) = self { _ = try ƒ(wrapped) }
    }
}

extension Optional where Wrapped: Collection {
    @inlinable public var isNilOrEmpty: Bool { self?.isEmpty ?? true }
    @inlinable public var ifNotEmpty: Self { isNilOrEmpty ? nil : self }
}

extension Optional {
    
    @discardableResult public static func `do`(
        log to: ((Error) -> ())? = nil,
        _ function: StaticString = #function,
        _ file: StaticString = #file,
        _ line: Int = #line,
        _ ƒ: () throws -> Wrapped
    ) -> Wrapped? {
        do { return try ƒ() } catch {
            if let log = to {
                log(error)
            } else {
                print("⚠️ \(error) \(here(function, file, line))")
            }
            return .none
        }
    }
}
