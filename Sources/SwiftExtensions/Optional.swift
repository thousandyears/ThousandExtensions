infix operator ?= : AssignmentPrecedence

public func ?= <A>(l: inout A, r: A?) {
    if let r = r { l = r }
}

extension Optional where Wrapped: Collection {
    @inlinable public var isNilOrEmpty: Bool { self?.isEmpty ?? true }
    @inlinable public var ifNotEmpty: Self { isNilOrEmpty ? nil : self }
}

extension Optional {
    
    @inlinable public func flatMap<A>(_ as: A.Type = A.self) -> A? {
        self as? A
    }

    @inlinable public func ifSome<Ignored>(_ ƒ: (Wrapped) throws -> Ignored) rethrows {
        if case let .some(wrapped) = self { _ = try ƒ(wrapped) }
    }
}

extension Optional {
    
    @discardableResult
    public static func `do`(
        log to: ((Error) -> ())? = nil,
        _ function: String = #function,
        _ file: String = #file,
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

extension Optional {
    
    @inlinable public func or(_ `default`: Wrapped) -> Wrapped {
        self ?? `default`
    }
    
    @inlinable public func or(
        _ function: String = #function,
        _ file: String = #file,
        _ line: Int = #line
    ) throws -> Wrapped {
        try or(throw: "⚠️".error(function, file, line))
    }
    
    @inlinable public func or(throw error: @autoclosure () -> Error) throws -> Wrapped {
        guard let o = self else { throw error() }
        return o
    }
}

extension Optional {
    
    public var description: String {
        switch self {
        case .none: return "\(Wrapped.self)?.none"
        case .some(let o): return "\(o)?"
        }
    }
}
