public protocol StrokeSpace {
    associatedtype Point: PointInSpace where Self.Point.D == Self
}

public extension StrokeSpace where Self: Real {
    typealias Point = Space.Point<Self>
}

extension Float: StrokeSpace {}
extension Double: StrokeSpace {}

public struct Stroke<In: StrokeSpace>: StrokeInSpace {

    public typealias D = In
    public typealias Point = In.Point

    public var start: Point
    public var moves: [Move]
    public var isClosed: Bool

    public init(start: Point = .zero, moves: [Move] = [], closed: Bool = false) {
        self.start = start
        self.moves = moves
        self.isClosed = closed
    }
}

public protocol StrokeInSpace {
    
    associatedtype Point: PointInSpace
    
    typealias Move = (
        destination: Point,
        control: (Point, Point?)?
    )
    
    var start: Point { get set }
    var moves: [Move] { get set }
    var isClosed: Bool { get set }
    
    init(start: Point, moves: [Move], closed: Bool)
}

public extension StrokeInSpace {
    typealias D = Point.D
}


