extension SKEmitterNode {
    
    public static func trail(rate: CGFloat = 0, in scene: SKScene?) throws -> SKEmitterNode {
        let view = scene?.view
        let o = SKEmitterNode()
        o.particleTexture = try SKTexture.spark(in: view)
        o.particleBlendMode = .alpha
        o.particleScale = 0.1
        o.particleBirthRate = 0
        o.particleLifetime = 30 / (scene?.physicsWorld.speed ?? 1)
        o.particleAlpha = 0.25
        o.particleAlphaSpeed = -(1 / o.particleLifetime) * o.particleAlpha
        return o
    }
}
