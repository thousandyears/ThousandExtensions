extension SKPhysicsContact {
    
    @inlinable public func isEitherNode<A>(_: A.Type) -> Bool {
        bodyA.node is A || bodyB.node is A
    }
    
    @inlinable public func areBothNodes<A>(_: A.Type) -> Bool {
        bodyA.node is A && bodyB.node is A
    }
    
    @inlinable public func areNodes<T1, T2>(_: T1.Type, and: T2.Type) -> Bool {
        (bodyA.node is T1 && bodyB.node is T2) || (bodyA.node is T2 && bodyB.node is T1)
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
