extension SKAction {
    
    public static var empty: SKAction { return .sequence([]) }
}

extension SKAction {
    
    public enum SpinDirection {
        case clockwise
        case anticlockwise
    }
}

extension SKAction {
    @inlinable public var forever: SKAction { .repeatForever(self) }
}

extension SKAction {
    @inlinable public static func sequence(_ actions: SKAction...) -> SKAction { .sequence(actions) }
    @inlinable public static func group(_ actions: SKAction...) -> SKAction { .group(actions) }
}

extension SKAction {
    
    public static func rotate(by angle: CGFloat, over t: TimeInterval) -> SKAction {
        return .rotate(byAngle: angle, duration: t)
    }
    
    @inlinable public static func `repeat`(_ action: SKAction) -> SKAction {
        .repeatForever(action)
    }
    
    @inlinable public static func `repeat`(
        every interval: TimeInterval,
        count: Int,
        _ ƒ: @escaping () -> ()
    ) -> SKAction {
        .repeat(
            .sequence(
                .run(ƒ),
                .wait(interval)
            ),
            count: count
        )
    }
    
    @inlinable public static func `repeat`<Object: AnyObject>(
        every interval: TimeInterval,
        count: Int,
        _ object: Object,
        _ ƒ: @escaping (Object) -> () -> ()
    ) -> SKAction {
        .repeat(
            .sequence(
                .run{ [weak object] in
                    guard let object = object else { return }
                    ƒ(object)()
                },
                .wait(interval)
            ),
            count: count
        )
    }

    @inlinable public static func wait(_ t: TimeInterval) -> SKAction {
        .wait(forDuration: t)
    }
    
    @inlinable public static func remove() -> SKAction {
        return .removeFromParent()
    }
}

extension SKAction {
    public static func group(@SKActionGroup _ group: () -> SKAction) -> SKAction { group() }
    public static func sequence(@SKActionSequence _ sequence: () -> SKAction) -> SKAction { sequence() }
}

@_functionBuilder
public struct SKActionGroup {
    
    public typealias Component = SKAction

    public static func merge(_ actions: [Component]) -> Component {
        .group(actions)
    }
    
    // repeated code ↓
    
    public static func buildBlock(_ components: Component...) -> Component {
        merge(components)
    }

    public static func buildIf(_ content: Component?) -> Component {
        merge([])
    }

    public static func buildEither(first component: Component) -> Component {
        component
    }

    public static func buildEither(second component: Component) -> Component {
        component
    }
    
    public static func buildDo(_ components: Component...) -> Component {
        merge(components)
    }
}

@_functionBuilder
public struct SKActionSequence {
    
    public typealias Component = SKAction

    public static func merge(_ actions: [Component]) -> Component {
        .sequence(actions)
    }
    
    // repeated code ↓
    
    public static func buildBlock(_ components: Component...) -> Component {
        merge(components)
    }

    public static func buildIf(_ content: Component?) -> Component {
        merge([])
    }

    public static func buildEither(first component: Component) -> Component {
        component
    }

    public static func buildEither(second component: Component) -> Component {
        component
    }
    
    public static func buildDo(_ components: Component...) -> Component {
        merge(components)
    }
}
