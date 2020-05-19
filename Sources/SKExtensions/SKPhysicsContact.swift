extension SKPhysicsContact {
    
    @inlinable public func isEitherNode<A>(_: A.Type) -> Bool {
        bodyA.node is A || bodyB.node is A
    }
    
    @inlinable public func areBothNodes<A>(_: A.Type) -> Bool {
        bodyA.node is A && bodyB.node is A
    }
    
    @inlinable public func areNodes<A, B>(_: A.Type, and: B.Type) -> Bool {
        isEitherNode(A.self) && isEitherNode(B.self)
    }
}

extension SKPhysicsContact {
    
    @inlinable public func first<A>(_: A.Type) -> A? {
        bodyA.node as? A ?? bodyB.node as? A
    }
    
    @inlinable public func last<A>(_: A.Type) -> A? {
        bodyB.node as? A ?? bodyA.node as? A
    }
}
