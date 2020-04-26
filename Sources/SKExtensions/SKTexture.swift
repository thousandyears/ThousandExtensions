extension SKTexture {
    
    public static func spark(
        circleRadius: CGFloat = 17,
        blurRadius: CGFloat = 12,
        color: SKColor = .white,
        in view: SKView?
    ) throws -> SKTexture {
        let o = SKShapeNode(CGCircle(radius: circleRadius) as CGDrawing)
        o.fillColor = color
        o.lineWidth = 0
        return try o.blurred(using: .GaussianBlur, by: blurRadius).texture(in: view)
    }
}

@available(OSX 10.13, *)
extension SKTexture {
    
    public static func shape(
        from layer: CAShapeLayer,
        for view: SKView? = nil
    ) throws -> (texture: SKTexture, scale: CGFloat) {
        let scale = view?.window?.backingScaleFactor ?? NSScreen.main?.backingScaleFactor ?? 2
        let image = try layer.image(scale: scale)
        return (SKTexture(cgImage: image), scale)
    }
}

extension SKTexture {
    
    public static func gradient(
        size: CGSize,
        angle: CGFloat,
        colors: [SKColor],
        for view: SKView? = nil
    ) throws -> (texture: SKTexture, scale: CGFloat) {
        let layer = CAGradientLayer()
        layer.colors = colors.map(\.cgColor)
        layer.angle = angle
        let scale = view?.window?.backingScaleFactor ?? NSScreen.main?.backingScaleFactor ?? 2
        layer.bounds.size = size * scale
        let c = try CGContext.rgb(preferredSize: layer.bounds.size)
        layer.render(in: c)
        let image = try c.makeImage().or()
        return (SKTexture(cgImage: image), scale)
    }
}
