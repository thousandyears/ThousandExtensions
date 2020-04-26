extension SKView {
    
    @available(OSX 10.13, *)
    public func texture(from layer: CAShapeLayer) throws -> (texture: SKTexture, scale: CGFloat) {
        let scale = window?.backingScaleFactor ?? NSScreen.main?.backingScaleFactor ?? 2
        let image = try layer.image(scale: scale)
        return (SKTexture(cgImage: image), scale)
    }
}
