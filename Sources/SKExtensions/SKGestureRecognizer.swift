#if canImport(AppKit)
import AppKit

public typealias SKClickGestureRecognizer = NSClickGestureRecognizer
public typealias SKGestureRecognizer = NSGestureRecognizer
public typealias SKMagnificationGestureRecognizer = NSMagnificationGestureRecognizer
public typealias SKPanGestureRecognizer = NSPanGestureRecognizer
public typealias SKRotationGestureRecognizer = NSRotationGestureRecognizer

#elseif canImport(UIKit)
import UIKit

public typealias SKClickGestureRecognizer = UITapGestureRecognizer
public typealias SKGestureRecognizer = UIGestureRecognizer
public typealias SKMagnificationGestureRecognizer = UIPinchGestureRecognizer
public typealias SKPanGestureRecognizer = UIPanGestureRecognizer
public typealias SKRotationGestureRecognizer = UIRotationGestureRecognizer

#endif

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
