import SwiftExtensions

#if canImport(QuartzCore)
extension CAShapeLayer: CGPencil {
    
    public func draw(_ o: CGStroke) {
        let path = self.path?.mutableCopy() ?? CGMutablePath()
        path.draw(o)
        self.path = path
    }
    
    public func draw(_ drawing: CGDrawing, using t: CGAffineTransform = .identity) {
        let path = self.path?.mutableCopy() ?? CGMutablePath()
        path.draw(drawing, using: t)
        self.path = path
    }
    
    public func draw(_ o: CGPolygonalChain) {
        let path = self.path?.mutableCopy() ?? CGMutablePath()
        path.draw(o)
        self.path = path
    }
    
    public func draw(_ o: CGRect) {
        let path = self.path?.mutableCopy() ?? CGMutablePath()
        path.draw(o)
        self.path = path
    }
    
    public func draw(_ o: CGEllipse) {
        let path = self.path?.mutableCopy() ?? CGMutablePath()
        path.draw(o)
        self.path = path
    }
}

extension CAShapeLayer {
    
    @available(OSX 10.13, iOS 11.0, *)
    public func image(scale: CGFloat) throws -> CGImage {
        let c = try CGContext.rgb(
            frame: path?.boundingBoxOfPath ?? .zero,
            padding: [lineWidth, miterLimit, shadowOffset.max + shadowRadius].max() ?? 0,
            scale: scale
        )
        render(in: c)
        return try c.makeImage().or(throw: "Could not make image".error())
    }
}
#endif
