extension CustomStringConvertible where Self: RawRepresentable, Self.RawValue == String {
    public var description: String { rawValue }
}
