extension SKNode {
    
    public func blurred(
        using type: CIFilter.Blur,
        by radius: CGFloat
    ) throws -> SKBlurEffectNode {
        let o = try SKBlurEffectNode(type: type, radius: radius)
        o.position = self.position
        removeFromParent()
        self.position = .zero
        o.addChild(self)
        return o
    }
}

open class SKBlurEffectNode: SKEffectNode {
    
    public let radius: CGFloat
    public let type: CIFilter.Blur
    
    open override var frame: CGRect {
        calculateAccumulatedFrame()
    }
    
    public required init?(coder: NSCoder) { fatalError() }

    public init(type: CIFilter.Blur = .GaussianBlur, radius: CGFloat) throws {
        self.radius = radius
        self.type = type
        super.init()
        filter = try CIFilter.blur(using: type, radius: radius)
    }
    
    open override func calculateAccumulatedFrame() -> CGRect {
        let o = super.calculateAccumulatedFrame()
        return CGRect(center: o.center, size: o.size + 2 * radius)
    }
}
