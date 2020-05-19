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

extension Int: CodingKey {
    public var stringValue: String { String(describing: self) }
    public var intValue: Int? { self }
    public init?(intValue: Int) { self = intValue }
    public init?(stringValue: String) { return nil }
}

extension String: CodingKey {
    public var stringValue: String { self }
    public var intValue: Int? { nil }
    public init?(intValue: Int) { return nil }
    public init?(stringValue: String) { self = stringValue }
}
