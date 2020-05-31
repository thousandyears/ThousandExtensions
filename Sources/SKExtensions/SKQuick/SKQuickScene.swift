#if os(macOS)
import Combine

public protocol SKDoNotClearNode: SKNode {}
public protocol SKUtilNode: SKNode {}

open class SKQuickScene: SKScene, SKPhysicsContactDelegate {

    open var selected: SKNode? { didSet { updateHighlight() } }
    
    open var dragged: (node: SKNode, delta: CGVector, dynamic: Bool)?
    
    public let keyboardShortcut$ = PassthroughSubject<SKQuickView.KeyboardShortcut, Never>()

    // TODO: create a pass-through subject for SKEvent (much more complex thank shortcuts ↑)
    public let mouseMoved$ = PassthroughSubject<SKEvent, Never>()
    public let mouseDragged$ = PassthroughSubject<SKEvent, Never>()
    
    // TODO: create a pass-through subject for gestures (possibly unified with mouse events ↑)
    public let panGesture$ = PassthroughSubject<SKPanGestureRecognizer, Never>()

    open var hasEdges: Bool = false {
        didSet {
            guard hasEdges != oldValue else { return }
            updateEdgeLoop()
        }
    }

    public required init?(coder: NSCoder) { fatalError() }

    public convenience override init() {
        self.init(size: .unit)
    }
    
    public override init(size: CGSize) {
        super.init(size: size)
        scaleMode = .resizeFill
        anchorPoint = .unit / 2
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        backgroundColor = .systemBlue
    }

    @objc open override func didChangeSize(_ oldSize: CGSize) {
        updateEdgeLoop()
    }
    
    private func updateEdgeLoop() {
        physicsBody = hasEdges ? .init(edgeLoopFrom: frame) : nil
    }
        
    //    @objc open func didBegin(_ contact: SKPhysicsContact) {
    //        if contact.areNodes(Planet.self, and: Sun.self) {
    //
    //        }
    //    }
}

extension SKQuickScene {
    
    open override func mouseMoved(with event: NSEvent) {
        mouseMoved$.send(event)
    }
    
    open override func mouseDragged(with event: NSEvent) {
        mouseDragged$.send(event)
    }
}

extension SKQuickScene {
    
    @objc open func click(gesture: SKClickGestureRecognizer) {
        trySelect(at: gesture.location(in: self))
    }
    
    @objc open func doubleClick(gesture: SKClickGestureRecognizer) {}

    @objc open func pan(gesture: SKPanGestureRecognizer) {
        drag(gesture)
        panGesture$.send(gesture)
    }
    
    @objc open func magnification(gesture: SKMagnificationGestureRecognizer) {
        children.first(SKGestureAdaptable.self)?.magnification(gesture: gesture)
    }

    @objc open func rotation(gesture: SKRotationGestureRecognizer) {
        children.first(SKGestureAdaptable.self)?.rotation(gesture: gesture)
    }
}

extension SKQuickScene {
    
    private class Highlight: SKShapeNode, SKUtilNode {}
    
    private static let highlight = Highlight(circleOfRadius: 66) + [
        \.name == "highlight",
        \.alpha == 0.075,
        \.fillColor == SKColor(white: 0, alpha: 0.5),
        \.strokeColor == SKColor(white: 0, alpha: 1),
        \.zPosition == -1000
    ]
    
    @objc open func updateHighlight() {
        self["//highlight"].forEach{
            if ($0.parent !== selected) {
                $0.removeFromParent()
            }
        }
        if let selected = selected, My.highlight.parent !== selected {
            My.highlight.removeFromParent()
            selected.addChild(My.highlight)
        }
    }
}

extension SKQuickScene {
    
    @objc open func isSelected(_ node: SKNode?, atLocationInParent point: CGPoint) -> Bool {
        guard let node = node, let parent = node.parent else { return false }
        if let path = (node as? SKDraggableShape)?.path {
            return path.contains(node.convert(point, from: parent))
        } else {
            return node.calculateAccumulatedFrame().contains(point)
        }
    }
    
    @objc open func trySelect(at location: CGPoint) {
        let node = children
            .except(SKUtilNode.self)
            .sorted{ $0.zPosition < $1.zPosition }
            .first{ isSelected($0, atLocationInParent: location) }
        
        select(node)
    }
    
    @objc(selectNode:)
    open func select(_ node: SKNode?) {
        selected = node is SKUtilNode ? nil : node
        selected?.zPosition = 1 + children.except(SKUtilNode.self).map(\.zPosition).max().or(0) // TODO: this should be opt-in
    }
    
    @objc open func deleteSelected() {
        selected?.removeFromParent()
        selected = nil
    }
    
    open func clear() {
        children.except(SKDoNotClearNode.self).forEach{ $0.removeFromParent() }
    }
}

extension SKQuickScene {
    
    @objc open func drag(_ gesture: SKPanGestureRecognizer) {
        guard let scene = scene else { return }
        let location = gesture.location(in: self)
        switch gesture.state
        {
        case .began:
            let sorted = scene.children.sorted{ $0.zPosition < $1.zPosition }
            guard let node = sorted.lazy
                .filter(SKDraggable.self)
                .first(where: { isSelected($0, atLocationInParent: location) })
                else
            { return }
            let delta = node.position - location
            dragged = (node, delta.cast(), node.physicsBody?.isDynamic ?? false)
            node.physicsBody?.isDynamic = false
            select(dragged?.node)
            
        case .changed:
            guard let (node, delta, _) = dragged else { return }
            node.position = location + delta
            
        case .ended, .cancelled, .failed:
            guard let (node, _, dynamic) = dragged else { return }
            node.physicsBody?.isDynamic = dynamic
            node.physicsBody?.velocity = gesture.velocity(in: view).cast()
            dragged = nil
            
        default:
            break
        }
    }
}

extension SKQuickScene {
    
    @propertyWrapper
    public struct SceneData<A> {
        
        private weak var scene: SKScene?
        public let id: UUID = .init()
        public let `default`: A
        
        public var wrappedValue: A {
            get {
                scene?.userData?.value(forKey: id.uuidString) as? A ?? self.default
            }
            set {
                if scene?.userData == nil { scene?.userData = .init() }
                scene?.userData?.setValue(newValue, forKey: id.uuidString)
            }
        }
        
        public init(init value: A, in scene: SKScene) {
            self.scene = scene
            self.default = value
            wrappedValue = value
        }
    }
}

extension SKQuickScene {
    
    private static let id = "SKQuickScene.userData"
    
    public var userInfo: [AnyHashable: Any] {
        get {
            userData?.value(forKey: SKQuickScene.id) as? [AnyHashable: Any] ?? [:]
        }
        set {
            if userData == nil { userData = .init() }
            userData?.setValue(newValue, forKey: SKQuickScene.id)
        }
    }
}

extension SKQuickScene { // TODO: deprecate - use keyboardShortcut$ instead
    @objc open func newDocument(_ sender: Any?) {}
    @objc open func cut(_ sender: Any?) {}
    @objc open func copy(_ sender: Any?) {}
    @objc open func paste(_ sender: Any?) {}
    @objc open func print(_ sender: Any?) {}
    @objc open func runPageLayout(_ sender: Any?) {}
}

extension SKQuickScene {
        
    @objc open override func scrollWheel(with event: SKEvent) {
        children.first(SKGestureAdaptable.self)?.scrollWheel(with: event)
    }
    
    @objc open override func keyDown(with event: SKEvent) {

    }
    
    @objc open override func keyUp(with event: SKEvent) {
        switch event.keyCode {
        case KeyboardKey.delete.code: deleteSelected()
        default:
            switch event.characters {
            case "§": deleteSelected()
            default:
                guard
                    event.modifierFlags.contains(.option),
                    let char = event.charactersIgnoringModifiers
                    else
                { break }
                switch char {
                case "f": view?.showsFields.toggle()
                case "d": view?.showsDrawCount.toggle()
                case "n": view?.showsNodeCount.toggle()
                case "p": view?.showsPhysics.toggle()
                case "s": view?.showsFPS.toggle()
                case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                    physicsWorld.speed = Int(char)!.cg.peek("✅ speed:")
                default: break
                }
            }
        }
    }
}
#endif
