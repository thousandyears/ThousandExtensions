extension CAShapeLayer {
    
    @available(OSX 10.13, *)
    public func image(scale: CGFloat) throws -> CGImage {
        let path = try self.path.or()
        let copy = try archivingBasedCopy()
        let pad = max(lineWidth, miterLimit)
        let box = path.boundingBoxOfPath.padded(by: pad)
        let c = try CGContext.rgb(preferredSize: box.size * scale)
        do {
            let o = CGMutablePath()
            o.addPath(path, transform: box.transform(to: c.bounds))
            copy.path = o
            copy.lineWidth *= scale
            copy.miterLimit *= scale
            copy.anchorPoint = .zero
            copy.position = .zero
            copy.bounds = c.bounds
            copy.render(in: c)
        }
        return try c.makeImage().or()
    }
}
