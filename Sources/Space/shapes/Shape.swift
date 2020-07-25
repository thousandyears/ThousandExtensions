public protocol ShapeInSpace {
    
    associatedtype Stroke: StrokeInSpace
    
    func shape() -> [Stroke]
}

public extension ShapeInSpace {
    typealias D = Stroke.D
}
