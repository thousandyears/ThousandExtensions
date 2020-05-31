public protocol SKGestureAdaptable: SKDraggable {
    var adaptedSize: CGSize { get set }
    var adaptedPreviewSize: CGSize { get set }
    var adaptedAngle: CGFloat { get set }
    var adaptedPreviewAngle: CGFloat { get set }
    func magnification(gesture: SKMagnificationGestureRecognizer)
    func rotation(gesture: SKRotationGestureRecognizer)
    
    #if canImport(AppKit)
    func handleScrollWheel(with event: SKEvent)
    #endif
}

extension SKGestureAdaptable {
    
    public func magnification(gesture: SKMagnificationGestureRecognizer) {
        switch gesture.state
        {
        case .began:
            adaptedPreviewSize = adaptedSize
            adaptedPreviewAngle = adaptedAngle

        case .changed:
            adaptedPreviewSize = adaptedSize * (1 + gesture.magnification)
            
        case .ended:
            adaptedSize = adaptedPreviewSize
            
        case .cancelled, .failed:
            adaptedPreviewSize = adaptedSize
        default:
            break
        }
    }

    public func rotation(gesture: SKRotationGestureRecognizer) {
        switch gesture.state
        {
        case .began:
            adaptedPreviewAngle = adaptedAngle
            adaptedPreviewSize = adaptedSize

        case .changed:
            adaptedPreviewAngle = adaptedAngle + gesture.rotation
            
        case .ended:
            adaptedAngle = adaptedPreviewAngle
            
        case .cancelled, .failed:
            adaptedPreviewAngle = adaptedAngle
            
        default:
            break
        }
    }
}

#if canImport(AppKit)
extension SKGestureAdaptable {
    public func handleScrollWheel(with event: SKEvent) {
        var size = adaptedSize
        size.height -= event.scrollingDeltaY / 100
        size.width += event.scrollingDeltaX / 100
        adaptedSize = size
        adaptedPreviewSize = size
    }
}
#endif

#if canImport(AppKit)
extension NSMagnificationGestureRecognizer {
    var scale: CGFloat {
        return magnification
    }
}
#elseif canImport(UIKit)
extension UIPinchGestureRecognizer {
    var magnification: CGFloat {
        return scale
    }
}
#endif
