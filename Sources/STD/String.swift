extension String {
    
    public static func * (l: String, r: Int) -> String {
        repeatElement(l, count: r).joined()
    }
}

extension String {

    public struct Error: Swift.Error, Hashable, CustomStringConvertible {
        public let description: String
    }

    public func error(_ function: StaticString = #function, _ file: StaticString = #file, _ line: Int = #line) -> Error {
        Error(description: "\(self) \(here(function, file, line))")
    }
}
