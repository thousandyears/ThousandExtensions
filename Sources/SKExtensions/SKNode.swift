extension SKNode {
    
    @inlinable
    @discardableResult
    public func add(_ nodes: SKNode...) -> Self {
        add(nodes)
    }
    
    @inlinable
    @discardableResult
    public func add(_ nodes: [SKNode]) -> Self {
        for node in nodes {
            if node.parent === self { continue }
            node.removeFromParent()
            addChild(node)
        }
        return self
    }
}

extension SKNode {
    
    @inlinable
    @discardableResult
    public func `in`(_ node: SKNode) -> Self {
        if parent === node { return self }
        removeFromParent()
        node.addChild(self)
        return self
    }
    
    @inlinable
    @discardableResult
    public func at(_ position: CGPoint) -> Self {
        self.position = position
        return self
    }
}

extension SKNode {
    
    @inlinable
    public func running(_ action: SKAction) -> Self {
        run(action)
        return self
    }
}

extension SKNode {
    
    @inlinable
    public var scale: CGFloat {
        get {
            guard xScale != yScale else {
                return (xScale + yScale) / 2
            }
            return xScale
        }
        set {
            let scale = newValue.isFinite ? newValue : 0
            xScale = scale
            yScale = scale
        }
    }
}

extension SKNode {
    
    open subscript<Case>(case: Case) -> [SKNode]
        where Case: RawRepresentable, Case.RawValue == String
    {
        self[`case`.rawValue]
    }
}

extension SKNode {
    
    @inlinable public func distance(to other: SKNode) -> CGFloat {
        position.distance(to: other.position)
    }
    
    @inlinable public func distance(to point: CGPoint) -> CGFloat {
        position.distance(to: point)
    }
}

extension SKNode {
    
    @inlinable public var scaleFactor: CGFloat? { scene?.view?.window?.scaleFactor }
}

extension CGPoint {
    
    @inlinable public func distance(to node: SKNode) -> CGFloat {
        distance(to: node.position)
    }
}

extension SKNode {
    
    public func texture(crop: CGRect? = nil, in view: SKView? = nil) throws -> SKTexture {
        let view = try (view ?? self.scene?.view).or(
            throw: (error(crop, view) + ": missing view").error()
        )
        let crop = crop ?? calculateAccumulatedFrame()
        return try view.texture(from: self, crop: crop).or(
            throw: error(crop, view).error()
        )
    }
    
    private func error(_ crop: CGRect?, _ view: SKView?) -> String {
        "⚠️ Failed \(Self.self).texture(crop: \(crop.debugDescription), view: \(view.debugDescription))"
    }
}

