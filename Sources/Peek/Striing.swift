extension String {

    public struct Error: Swift.Error, Hashable, CustomStringConvertible {
        public let description: String
        public init(_ description: String) { self.description = description }
    }

    @inlinable public func error(_ function: String = #function, _ file: String = #file, _ line: Int = #line) -> Error {
        Error(self.here(function, file, line))
    }
}

extension String {
    
    @inlinable public func here(_ function: String = #function, _ file: String = #file, _ line: Int = #line) -> String {
        "\(self) \(CodeLocation(function, file, line))"
    }
}
