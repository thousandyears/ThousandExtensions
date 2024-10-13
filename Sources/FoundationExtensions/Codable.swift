extension Encodable {
    
    public var debugDescription: String {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(self)
            return try String(data: data, encoding: .utf8).or()
        } catch {
            return "\(Self.self) [⚠️ failed to encode]"
        }
    }
}

extension Int: @retroactive CodingKey {
    public var stringValue: String { String(describing: self) }
    public var intValue: Int? { self }
    public init?(intValue: Int) { self = intValue }
    public init?(stringValue: String) { return nil }
}

extension String: @retroactive CodingKey {
    public var stringValue: String { self }
    public var intValue: Int? { nil }
    public init?(intValue: Int) { return nil }
    public init?(stringValue: String) { self = stringValue }
}

extension Sequence where Element == CodingKey {
    public var prettyDescription: String {
        enumerated().map { i, key in
            if let idx = key.intValue {
                return "[\(idx)]"
            } else {
                return (i > 0 ? "." : "") + key.stringValue
            }
        }.joined()
    }
}

extension DecodingError.Context {
    public var codingPathDescription: String { codingPath.prettyDescription }
}

extension EncodingError.Context {
    public var codingPathDescription: String { codingPath.prettyDescription }
}
