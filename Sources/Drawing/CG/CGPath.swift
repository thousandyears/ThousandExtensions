extension CGDrawing {
    
    @inlinable public func path() -> CGMutablePath {
        let o = CGMutablePath()
        draw(with: o)
        return o
    }
}

extension CGMutablePath: CGPencil {
    
    public func draw(_ o: CGStroke) {
        move(to: o.start)
        for o in o.moves {
            switch o.count {
            case 1: addLine(to: o[0])
            case 2: addQuadCurve(to: o[0], control: o[1])
            case 3...: addCurve(to: o[0], control1: o[1], control2: o[2])
            default: continue
            }
        }
        if o.isClosed { closeSubpath() }
    }
    
    public func draw(_ o: CGDrawing, using t: CGAffineTransform = .identity) {
        addPath(o.path(), transform: t)
    }
    
    public func draw(_ o: CGPolygonalChain) {
        addLines(between: o.vertices)
        if !o.isEmpty, o.isClosed { closeSubpath() }
    }
    
    public func draw(_ o: CGRect) {
        addRect(o)
    }
    
    public func draw(_ o: CGEllipse) {
        addEllipse(in: o.frame)
    }
}

extension CGMutablePath {
    
    public func after(_ ƒ: (Self) -> ()) -> Self {
        ƒ(self)
        return self
    }
}

extension CGPath {

    public func applying(_ t: CGAffineTransform) -> CGPath {
        let o = CGMutablePath()
        o.addPath(self, transform: t)
        return o
    }
    
    public func transform(to bounds: CGRect) -> CGAffineTransform {
        let box = boundingBoxOfPath
        guard box.size.area > 0 else { return .identity }
        return box.transform(to: bounds)
    }
    
    public func fitting(into bounds: CGRect) -> CGPath {
        applying(transform(to: bounds))
    }
}

#if canImport(AppKit)

import AppKit

extension CGPath: CustomPlaygroundDisplayConvertible {

    public var playgroundDescription: Any {
        let o = CAShapeLayer()
        o.fillRule = .evenOdd
        o.backgroundColor = .clear
        o.strokeColor = NSColor.systemBlue.cgColor
        o.fillColor = NSColor.systemBlue.withAlphaComponent(0.2).cgColor
        o.lineWidth = 1
        o.path = self
        o.fitBoundsToPath()
        return o.playgroundDescription
    }
}

extension CAShapeLayer: CustomPlaygroundDisplayConvertible {
    
    public var playgroundDescription: Any {
        guard frame.size.area > 0 else { return "Zero area \(type(of: self))" }
        let view = NSView(frame: frame)
        let base = CALayer()
        view.layer = base
        base.addSublayer(self)
        return view
    }
}

extension CAShapeLayer {
    
    func fitBoundsToPath() {
        guard let path = path else { return }
        var box = path.boundingBoxOfPath
        let padding = max(lineWidth, miterLimit)
        box.size += padding * 2
        box.origin -= padding
        bounds = box
        anchorPoint = .zero
    }
}
#endif
