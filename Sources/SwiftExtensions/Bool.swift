extension Bool {
    @inlinable public var not: Bool { !self }
}

@inlinable
public func not(_ bool: Bool) -> Bool { !bool }

@inlinable
public func not(_ predicate: @escaping () throws -> Bool) -> () throws -> Bool {
    { try !predicate() }
}

@inlinable
public func not<A>(_ predicate: @escaping (A) throws -> Bool) -> (A) throws -> Bool {
    { try !predicate($0) }
}

@inlinable
public func not<A, B>(_ predicate: @escaping (A, B) throws -> Bool) -> (A, B) throws -> Bool {
    { try !predicate($0, $1) }
}

extension Bool {
    
    public static func &&= (lhs: inout Bool, rhs: Bool) {
        lhs = lhs && rhs
    }
    
    public static func ||= (lhs: inout Bool, rhs: Bool) {
        lhs = lhs || rhs
    }
}
