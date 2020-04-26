open class SKPencilNode: SKShapeNode {
    
    private var pencil = CGMutablePath()
}

extension SKPencilNode {
    
    private func update(ƒ: (CGMutablePath) -> ()) -> Self {
        ƒ(pencil)
        path = pencil // TODO: animate
        return self
    }
}

extension SKPencilNode: CGPencil {
    
    public func draw(_ o: CGStroke) {
        pencil.draw(o)
    }
    
    public func draw(_ drawing: CGDrawing, using: CGAffineTransform) {
        pencil.draw(drawing, using: using)
    }
    
    public func draw(_ o: CGPolygonalChain) {
        pencil.draw(o)
    }
    
    public func draw(_ o: CGRect) {
        pencil.draw(o)
    }
    
    public func draw(_ o: CGEllipse) {
        pencil.draw(o)
    }
}
