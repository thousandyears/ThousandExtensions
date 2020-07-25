public struct CGVoid: Codable, Equatable {
    public init() {}
}

extension CGVoid: CGDrawing {
    
    @inlinable public func draw(with pencil: CGPencil) {}
    
    @inlinable public var debugDescription: String {
        "\(CGVoid.self)"
    }
}
