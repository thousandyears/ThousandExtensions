extension SKTexture {
    
    @MainActor public static func spark(
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

extension SKTexture {
        
    @MainActor public static func from(
        _ layer: CAShapeLayer,
        scale: CGFloat? = nil
    ) throws -> (texture: SKTexture, scale: CGFloat) {
        try layer.skTexture(scale: scale)
    }

    @MainActor public convenience init(from layer: CAShapeLayer, scale: CGFloat? = nil) throws {
        try self.init(cgImage: layer.image(scale: scale ?? SKScreen.scaleFactor))
    }
}

extension CAShapeLayer {
    
    @MainActor public func skTexture(scale: CGFloat? = nil) throws -> (texture: SKTexture, scale: CGFloat) {
        let scale = scale ?? SKScreen.scaleFactor
        return try (SKTexture(cgImage: image(scale: scale)), scale)
    }
}

extension SKTexture {
    
    @MainActor public static func gradient( // TODO: refactor image creation to CAGradientLayer or CGContext
        size: CGSize,
        angle: CGFloat,
        colors: [SKColor],
        for view: SKView? = nil
    ) throws -> (texture: SKTexture, scale: CGFloat) {
        let layer = CAGradientLayer()
        layer.colors = colors.map(\.cgColor)
        layer.angle = angle
        let scale = view?.window?.scaleFactor ?? SKScreen.scaleFactor
        layer.bounds.size = size * scale
        let c = try CGContext.rgb(size: layer.bounds.size, scale: 1)
        layer.render(in: c)
        let image = try c.makeImage().or()
        return (SKTexture(cgImage: image), scale)
    }
}
