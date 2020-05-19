extension SKShapeNode {
    
    @inlinable public convenience init(_ drawing: CGDrawing) {
        self.init(path: drawing.path())
    }
}

extension CGDrawing {
    
    @discardableResult
    public func `in`(_ node: SKNode) -> SKShapeNode {
        let o = SKShapeNode(self)
        node.addChild(o)
        return o
    }
}
