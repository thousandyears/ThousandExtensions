open class SKCrossPlatformScene: SKScene, SKPhysicsContactDelegate {
    
    public let gesture = (
        pan$: PassthroughSubject<SKPanGestureRecognizer, Never>(),
        click$: PassthroughSubject<SKClickGestureRecognizer, Never>()
    )
    
    open internal(set) var possiblePanBeganLocation: CGPoint?

    // TODO: multiple published selection
    open internal(set) var selected: (node: SKNode, zPosition: CGFloat)?
    
    // TODO: multiple published dragged nodes
    open internal(set) var dragged: (node: SKNode, delta: CGVector, dynamic: Bool?)?
    
    open var bag: Set<AnyCancellable> = []

    open override func sceneDidLoad() {
        scaleMode = .resizeFill
        anchorPoint = .unit / 2
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        backgroundColor = .black
        isUserInteractionEnabled = true
    }
}

extension SKCrossPlatformScene {
    
    open override func didMove(to view: SKView) {
        view.gestureRecognizers = [
            SKClickGestureRecognizer(target: self, action: #selector(click(gesture:))),
            // SKClickGestureRecognizer(target: self, action: #selector(doubleClick(gesture:)), count: 2),
            // SKMagnificationGestureRecognizer(target: self, action: #selector(magnification(gesture:))),
            SKPanGestureRecognizer(target: self, action: #selector(pan(gesture:))),
            // SKRotationGestureRecognizer(target: self, action: #selector(rotation(gesture:))),
        ]
        .map{
            #if os(macOS)
            $0.delaysPrimaryMouseButtonEvents = false // buggy default
            $0.delaysSecondaryMouseButtonEvents = false // buggy default
            #endif
            return $0
        }
    }
}

// TODO: more performant selection and dragging implementation
// TODO: store gesture data (ready for federated learning)

extension SKCrossPlatformScene {
    
    @objc open func click(gesture: SKClickGestureRecognizer) {
        select(at: gesture.location(in: self))
        self.gesture.click$.send(gesture)
    }

    open func top<Node: SKNode>(_ type: Node.Type, at location: CGPoint) -> SKNode? {
        let sorted = children.sorted{ $0.zPosition < $1.zPosition }
        return sorted.lazy
            .filter(SKDraggable.self)
            .first(where: { isSelected($0, atLocationInParent: location) })
    }

    @objc open func isSelected(_ node: SKNode?, atLocationInParent point: CGPoint) -> Bool {
        guard
            let node = node,
            let parent = node.parent
        else { return false }
        if let path = (node as? SKSelectableShape)?.path {
            return path.contains(node.convert(point, from: parent))
        } else {
            return node.contains(point)
        }
    }

    @discardableResult
    @objc open func select(at location: CGPoint) -> SKNode? {
        let node = children
            .filter(SKSelectable.self)
            .sorted{ $0.zPosition < $1.zPosition }
            .first{ isSelected($0, atLocationInParent: location) }
        
        select(node)
        return node
    }
    
    @objc(selectNode:)
    open func select(_ node: SKNode? = nil) {
        guard selected?.node !== node else { return }
        selected?.node.zPosition ?= selected?.zPosition
        guard let node = node is SKSelectable ? node : nil else {
            selected = nil
            return
        }
        node.zPosition = 1 + children.filter(SKSelectable.self).map(\.zPosition).max().or(0)
        selected = (node, node.zPosition)
    }
}

extension SKCrossPlatformScene {
    
    @objc open func pan(gesture: SKPanGestureRecognizer) {
        drag(gesture: gesture)
        self.gesture.pan$.send(gesture)
    }
    
    #if os(iOS) || os(tvOS)
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        possiblePanBeganLocation = touches.first?.location(in: self)
        possiblePanBeganLocation.ifSome(touchDown(at:))
    }
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        (touches.first?.location(in: self)).ifSome(didPan(to:))
    }
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        (touches.first?.location(in: self)).ifSome(tuchUp(at:))
    }
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        (touches.first?.location(in: self)).ifSome(tuchUp(at:))
    }
    #elseif os(macOS)
    open override func mouseDown(with event: NSEvent) {
        possiblePanBeganLocation = event.location(in: self)
        possiblePanBeganLocation.ifSome(touchDown(at:))
    }
    open override func mouseDragged(with event: NSEvent) {
        didPan(to: event.location(in: self))
    }
    open override func mouseUp(with event: NSEvent) {
        tuchUp(at: event.location(in: self))
    }
    #endif
    
    @objc open func touchDown(at location: CGPoint) {
        // override point
    }
    
    @objc open func didPan(to location: CGPoint) {
        // override point
    }

    @objc open func tuchUp(at location: CGPoint) {
        // override point
    }

    @objc open func drag(gesture: SKPanGestureRecognizer) {
        
        let location: CGPoint = {
            switch gesture.state
            {
            case .began:
                let o = possiblePanBeganLocation ?? gesture.location(in: self)
                possiblePanBeganLocation = nil
                return o
                
            default:
                possiblePanBeganLocation = nil
                return gesture.location(in: self)
            }
        }()
        
        switch gesture.state
        {
        case .possible:
            break
            
        case .began:
            guard let node = top(SKDraggable.self, at: location) else { return }
            let delta = node.position - location
            dragged = (node, delta.cast(), node.physicsBody?.isDynamic ?? false)
            node.physicsBody?.isDynamic = false
            select(dragged?.node)
            willBeginDragging(node: node)
            
        case .changed:
            guard let (node, delta, _) = dragged else { return }
            node.position = location + delta
            didDrag(node: node)
            
        case .ended, .cancelled, .failed:
            guard let (node, _, dynamic) = dragged else { return }
            node.physicsBody?.isDynamic ?= dynamic
            node.physicsBody?.velocity = gesture.velocity(in: view).cast()
            dragged = nil
            didEndDragging(node: node)
            
        @unknown default:
            break
        }
    }
    
    @objc open func willBeginDragging(node: SKNode) {
        // override point
    }
    
    @objc open func didDrag(node: SKNode) {
        // override point
    }
    
    @objc open func didEndDragging(node: SKNode) {
        // override point
    }
}
