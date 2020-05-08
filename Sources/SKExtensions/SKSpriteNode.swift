extension SKSpriteNode {
    
    public convenience init(from layer: CAShapeLayer, scale: CGFloat? = nil) {
        do {
            let (texture, scale) = try layer.skTexture(scale: scale)
            self.init(texture: texture, size: texture.size() / scale)
        }
        catch {
            error.localizedDescription.peek("⚠️")
            self.init()
        }
    }
}

