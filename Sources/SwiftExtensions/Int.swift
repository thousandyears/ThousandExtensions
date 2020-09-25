extension IntegerLiteralType: CustomDebugStringConvertible {
    
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
