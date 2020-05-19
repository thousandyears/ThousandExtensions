extension SKPhysicsJoint {
    
    public func `is`(between this: SKPhysicsBody?, and that: SKPhysicsBody?) -> Bool {
        guard let this = this, let that = that else { return false }
        return self.is(between: this, and: that)
    }
    
    public func `is`(between this: SKPhysicsBody, and that: SKPhysicsBody) -> Bool {
        return bodyA === this && bodyB === that
            || bodyB === this && bodyA === that
    }
}

extension SKPhysicsBody {
    
    @inlinable
    public func isJoined(to other: SKPhysicsBody) -> Bool {
        joints.contains{ $0.is(between: self, and: other) }
    }
    
    @inlinable
    public func joint(to other: SKPhysicsBody) -> [SKPhysicsJoint] {
        joints.filter{ $0.is(between: self, and: other) }
    }
}
