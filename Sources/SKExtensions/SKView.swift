extension SKView {
    
    @available(OSX 10.13, iOS 11.0, *)
    public func texture(from layer: CAShapeLayer) throws -> (texture: SKTexture, scale: CGFloat) {
        let scale = window?.scaleFactor ?? SKScreen.scaleFactor
        let image = try layer.image(scale: scale)
        return (SKTexture(cgImage: image), scale)
    }
}
