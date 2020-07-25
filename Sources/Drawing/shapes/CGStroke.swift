public struct CGStroke: Equatable, Codable {
    
    public var start: CGPoint
    public var moves: [[CGPoint]]
    public var isClosed: Bool
    
    public init(start: CGPoint = .zero, moves: [[CGPoint]] = [], closed: Bool = false) {
        self.start = start
        self.moves = moves
        self.isClosed = closed
    }
}

extension CGStroke {
    
    public static let zero: CGStroke = .init()
    public static let unit: CGStroke = .init(moves: [[.unit]])
}

extension CGStroke {
    
    @inlinable public init(_ start: CGPoint, _ moves: [CGPoint]..., closed: Bool = false) {
        self.init(start: start, moves: moves, closed: closed)
    }
}

extension CGStroke: CGDrawing {
    
    @inlinable public func draw(with pencil: CGPencil) {
        pencil.draw(self)
    }
    
    @inlinable public var debugDescription: String {
        "\(CGStroke.self)(start: \(start), moves: \(moves), closed: \(isClosed))"
    }
}
