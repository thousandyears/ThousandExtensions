open class SKShapeFlipNode: SKSpriteNode {
    
    open var fps: CGFloat = 30 { didSet { reset() } }
    
    open var pictures: [Picture] = [] { didSet { reset() } }
    
    open var style = CAShapeLayer() + [
        \.strokeColor == .white,
        \.fillRule == .evenOdd,
        \.lineCap == .round,
        \.lineJoin == .round,
    ]
    
    open private(set) var textures: [SKTexture] = []
    
    public convenience init() {
        self.init(texture: nil, color: .clear, size: .zero)
    }
    
    public required init?(coder: NSCoder) { fatalError() }
    
    public override init(texture: SKTexture?, color: SKColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    open func resetAnimation() {
        startFlipAnimation()
    }
    
    open func startFlipAnimation() {
        guard textures.isEmpty.not else {
            "⚠️ Textures are empty".peek(as: .error)
            return
        }
        stopFlipAnimation()
        let a = SKAction.animate(with: textures, timePerFrame: 1 / fps.d).forever
        run(a, withKey: "texture flip")
    }
    
    open func stopFlipAnimation() {
        removeAction(forKey: "texture flip")
    }
    
    private func reset() {
        guard pictures.isEmpty.not else {
            return
        }
        
        let o = self.style
        
        var textures: [SKTexture] = []
        var size = CGSize.zero
        
        for picture in pictures {
            let thisSize: CGSize
            if let (texture, scale) = picture.rendered {
                textures.append(texture)
                thisSize = texture.size() / scale
            } else {
                do {
                    if picture.style.stroke.glowWidth > 0 {
                        o.shadowOpacity = 1
                        o.shadowColor = o.strokeColor
                        o.shadowOffset = .zero
                        o.shadowRadius = picture.style.stroke.glowWidth
                    } else {
                        o.shadowOpacity = 0
                    }
                    o.lineWidth = picture.style.stroke.lineWidth
                    o.strokeColor = o.strokeColor?.copy(alpha: picture.style.stroke.alpha)
                    o.fillColor = o.strokeColor?.copy(alpha: picture.style.fill.alpha)
                    o.path = picture.path
                    let (texture, scale) = try o.skTexture(scale: scaleFactor)
                    thisSize = texture.size() / scale
                    textures.append(texture)
                    picture.rendered = (texture, scale)
                } catch {
                    error.peek("⚠️")
                    continue
                }
            }
            size = .init( // TODO: fix the problem of the stretching textures
                width: max(thisSize.width, size.width),
                height: max(thisSize.height, size.height)
            )
        }
        guard textures.isEmpty.not else {
            "There were no textures to animate".peek("⚠️")
            return
        }
        self.textures = textures
        self.size = size
        resetAnimation()
    }
}

extension SKShapeFlipNode {
    
    public class Picture {
        
        public var path: CGPath
        public var style: CGShapeStyle
        
        public fileprivate(set) var rendered: (
            texture: SKTexture,
            scale: CGFloat
        )?
        
        public init(_ path: CGPath, _ style: CGShapeStyle = .init()) {
            self.path = path
            self.style = style
        }
    }
    
    public class PictureNode: SKShapeNode {}
}

extension SKShapeFlipNode.Picture {
    
    @MainActor public convenience init(_ drawing: CGDrawing, _ style: CGShapeStyle = .init()) {
        self.init(drawing.path(), style)
    }
}
