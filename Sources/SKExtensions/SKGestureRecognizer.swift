#if os(macOS)
public typealias SKClickGestureRecognizer = NSClickGestureRecognizer
public typealias SKGestureRecognizer = NSGestureRecognizer
public typealias SKMagnificationGestureRecognizer = NSMagnificationGestureRecognizer
public typealias SKPanGestureRecognizer = NSPanGestureRecognizer
public typealias SKRotationGestureRecognizer = NSRotationGestureRecognizer
public typealias SKTapGestureRecognizer = NSClickGestureRecognizer
#endif

#if os(iOS) || os(tvOS)
public typealias SKClickGestureRecognizer = UITapGestureRecognizer
public typealias SKGestureRecognizer = UIGestureRecognizer
public typealias SKPanGestureRecognizer = UIPanGestureRecognizer
public typealias SKTapGestureRecognizer = UITapGestureRecognizer
#endif

#if os(iOS)
public typealias SKMagnificationGestureRecognizer = UIPinchGestureRecognizer
public typealias SKRotationGestureRecognizer = UIRotationGestureRecognizer
#endif

#if os(iOS) || os(tvOS) || os(macOS)
extension SKNode {
    
    public func location(of gesture: SKGestureRecognizer) -> CGPoint {
        gesture.location(in: self)
    }
}

extension SKGestureRecognizer {
    
    public func location(in node: SKNode) -> CGPoint {
        guard
            let view = view as? SKView,
            let scene = view.scene,
            scene === node || scene === node.scene
            else
        {
            assert(false)
            return .zero
        }
        let point = scene.convertPoint(fromView: location(in: view))
        return node === scene ? point : node.convert(point, from: scene)
    }
}
#endif

#if os(iOS) || os(macOS)
extension SKClickGestureRecognizer {
    
    public convenience init(target: Any?, action: Selector?, count: Int) {
        self.init(target: target, action: action)
        #if os(macOS)
        numberOfClicksRequired = count
        #elseif os(iOS)
        numberOfTouchesRequired = count
        #endif
    }
}
#endif
