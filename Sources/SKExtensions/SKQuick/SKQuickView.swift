#if os(macOS)
public class SKQuickView: SKView {
    
    public var quickScene: SKQuickScene { scene as! SKQuickScene }
    
    public required init?(coder: NSCoder) { fatalError() }
    
    public convenience init() {
        self.init(frame: .unit)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        ignoresSiblingOrder = true
    }
    
    public override func presentScene(_ scene: SKScene, transition: SKTransition) {
        onPresentScene(scene)
        super.presentScene(scene, transition: transition)
    }
    
    public override func presentScene(_ scene: SKScene?) {
        onPresentScene(scene)
        super.presentScene(scene)
    }
    
    private func onPresentScene(_ scene: SKScene?) {
        guard let scene = scene as? SKQuickScene else {
            fatalError("Can only present a SKQuickScene")
        }
        setGestureTarget(to: scene)
    }
}

extension SKQuickView {
    
    @objc open func newDocument(_ sender: Any?) {
        quickScene.newDocument(sender)
    }
    
    @objc open func cut(_ sender: Any?) {
        quickScene.cut(sender)
    }
    
    @objc open func copy(_ sender: Any?) {
        quickScene.copy(sender)
    }
    
    @objc open override func changeMode(with event: NSEvent) {
        event.peek()
    }
    
    @objc open func paste(_ sender: Any?) {
        quickScene.paste(sender)
    }
    
    @objc open func print(sender: Any?) {
        quickScene.print(sender)
    }
    
    @objc open func runPageLayout(_ sender: Any?) {
        quickScene.runPageLayout(sender)
    }
    
    @objc open override func scrollWheel(with event: NSEvent) {
        quickScene.scrollWheel(with: event)
    }
}

private extension SKQuickView {

    func setGestureTarget(to scene: SKQuickScene) {
        gestureRecognizers.forEach(removeGestureRecognizer)
        let all = [
            SKClickGestureRecognizer(target: scene, action: #selector(SKQuickScene.click(gesture:))),
            SKMagnificationGestureRecognizer(target: scene, action: #selector(SKQuickScene.magnification(gesture:))),
            SKPanGestureRecognizer(target: scene, action: #selector(SKQuickScene.pan(gesture:))),
            SKRotationGestureRecognizer(target: scene, action: #selector(SKQuickScene.rotation(gesture:))),
        ]
        all.forEach(addGestureRecognizer)
    }
}
#endif
