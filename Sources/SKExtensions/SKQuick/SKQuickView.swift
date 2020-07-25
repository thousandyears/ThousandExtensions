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
}

extension SKQuickView {
    
    @objc public override func presentScene(_ scene: SKScene, transition: SKTransition) {
        onPresentScene(scene)
        super.presentScene(scene, transition: transition)
    }
    
    @objc public override func presentScene(_ scene: SKScene?) {
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

#if canImport(AppKit)
extension SKQuickView {
    
    public enum KeyboardShortcut: String {
        case newDocument
        case cut
        case copy
        case paste
        case print
        case runPageLayout
    }

    @objc open func newDocument(_ sender: Any?) {
        quickScene.newDocument(sender) // TODO: deprecate
        quickScene.keyboardShortcut$.send(.newDocument)
    }
    
    @objc open func cut(_ sender: Any?) {
        quickScene.cut(sender) // TODO: deprecate
        quickScene.keyboardShortcut$.send(.cut)
    }
    
    @objc open func copy(_ sender: Any?) {
        quickScene.copy(sender) // TODO: deprecate
        quickScene.keyboardShortcut$.send(.copy)
    }
    
    @objc open func paste(_ sender: Any?) {
        quickScene.paste(sender) // TODO: deprecate
        quickScene.keyboardShortcut$.send(.paste)
    }
    
    @objc open func print(sender: Any?) {
        quickScene.print(sender) // TODO: deprecate
        quickScene.keyboardShortcut$.send(.print)
    }
    
    @objc open func runPageLayout(_ sender: Any?) {
        quickScene.runPageLayout(sender) // TODO: deprecate
        quickScene.keyboardShortcut$.send(.runPageLayout)
    }
}
#endif

#if canImport(AppKit)
extension SKQuickView {
    
    @objc open override func changeMode(with event: NSEvent) {
        event.peek()
    }

    @objc open override func scrollWheel(with event: NSEvent) {
        quickScene.scrollWheel(with: event)
    }
}
#endif

private extension SKQuickView {

    func setGestureTarget(to scene: SKQuickScene) {
        #if canImport(AppKit)
        gestureRecognizers.forEach(removeGestureRecognizer)
        #elseif canImport(UIKit)
        gestureRecognizers?.forEach(removeGestureRecognizer)
        #endif
        let all = [
            SKClickGestureRecognizer(target: scene, action: #selector(SKQuickScene.click(gesture:))),
            SKClickGestureRecognizer(target: scene, action: #selector(SKQuickScene.doubleClick(gesture:)), count: 2),
            SKMagnificationGestureRecognizer(target: scene, action: #selector(SKQuickScene.magnification(gesture:))),
            SKPanGestureRecognizer(target: scene, action: #selector(SKQuickScene.pan(gesture:))),
            SKRotationGestureRecognizer(target: scene, action: #selector(SKQuickScene.rotation(gesture:))),
        ]
        all.forEach(addGestureRecognizer)
    }
}
#endif
