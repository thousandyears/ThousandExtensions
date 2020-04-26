extension SKShapeNode {
    
    @inlinable public convenience init(_ drawing: CGDrawing) {
        self.init(path: drawing.path())
    }
}
