extension IntegerLiteralType: @retroactive CustomDebugStringConvertible {
    
    @inlinable public var debugDescription: String { description }
}

extension IntegerLiteralType {
    
    @inlinable public func of<T>(_ ƒ: () throws -> T) rethrows -> [T] {
        try self < 1 ? [] : (1...self).map{ _ in try ƒ() }
    }
    
    @inlinable public func times<Ignore>(_ ƒ: () throws -> Ignore) rethrows {
        if self > 0 { try (1...self).forEach{ _ in _ = try ƒ() } }
    }
}

extension Int {
    
    @inlinable public var isEven: Bool { self % 2 == 0 }
    @inlinable public var isOdd: Bool { isEven == false }
}
