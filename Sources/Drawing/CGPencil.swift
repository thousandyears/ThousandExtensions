public protocol CGPencil: AnyObject {
    
    func draw(_ stroke: CGStroke)
    func draw(_ drawing: CGDrawing, using: CGAffineTransform)
    
    // TODO: add default implementations:
    func draw(_ polygon: CGPolygonalChain)
    func draw(_ rect: CGRect)
    func draw(_ ellipse: CGEllipse)
}

extension CGPencil {
    
    @inlinable public func draw(_ circle: CGCircle) {
        draw(circle.ellipse)
    }
    
    @inlinable public func draw<Points>(_ points: Points) where Points: Sequence, Points.Element == CGPoint {
        draw(CGPolygonalChain(points))
    }
}

