import Foundation

infix operator ¶ : TernaryPrecedence

@discardableResult
public func ¶ <L, R>(l: L, r: R) -> L {
    #if DEBUG
    print(r, l)
    #endif
    return l
}

public struct Peek {
    
    public let log: () -> String
    public let date: Date
    public let location: CodeLocation

    public init<A>(
        _ a: A,
        _ keyPath: PartialKeyPath<A>,
        _ message: Any?,
        _ function: String = #function,
        _ file: String = #file,
        _ line: Int = #line
    ) {
        self.date = Date()
        self.location = here(function, file, line)
        self.log = { [location] in
            var o = ""
            print(message ?? "•", a[keyPath: keyPath], location, terminator: "", to: &o)
            return o
        }
    }
}

extension Peek: CustomStringConvertible, CustomDebugStringConvertible {
    @inlinable public var description: String { log() }
    @inlinable public var debugDescription: String { log() }
}
