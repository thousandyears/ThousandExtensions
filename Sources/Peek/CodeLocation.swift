public typealias here = CodeLocation

@discardableResult public func ... <T>(l: T, r: here) -> T {
    #if DEBUG
    print(l, r)
    #endif
    return l
}

public struct CodeLocation: Codable, Hashable {
    public var function: String
    public var file: String
    public var line: Int
}

extension CodeLocation {
    public init(
        _ function: String = #function,
        _ file: String = #file,
        _ line: Int = #line
    ) {
        self.function = function
        self.file = file
        self.line = line
    }
}

extension CodeLocation: CustomDebugStringConvertible, CustomStringConvertible {
    
    public var debugDescription: String {
        "\(function) \(file) \(line)"
    }
    
    public var description: String {
        var file = self.file
        if let i = file.lastIndex(of: "/") {
            file = file.suffix(from: i).description
        }
        return "\(function) \(file) \(line)"
    }
}
