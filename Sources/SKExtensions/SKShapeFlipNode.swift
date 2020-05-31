#if os(macOS) // TODO: for iOS
import Combine

@available(OSX 10.13, *) // TODO: make sure it works on iOS
open class SKShapeFlipNode: SKSpriteNode {
    
    open var fps: CGFloat = 30 { didSet { reset() } }
    
    open var pictures: [Picture] = [] { didSet { reset() } }
    
    open private(set) var textures: [SKTexture] = []
    
    public convenience init() {
        self.init(texture: nil, color: .clear, size: .zero)
    }
    
    public required init?(coder: NSCoder) { fatalError() }
    
    public override init(texture: SKTexture?, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    open func resetAnimation() {
        guard textures.isEmpty.not else {
            "⚠️ Textures are empty".peek()
            return
        }
        removeAction(forKey: "texture flip")
        let a = SKAction.animate(with: textures, timePerFrame: 1 / fps.d).forever
        run(a, withKey: "texture flip")
    }
    
    private func reset() {
        guard pictures.isEmpty.not else {
            return
        }
        
        let o = CAShapeLayer()
        o.strokeColor = .white
        o.fillColor = SKColor(white: 1, alpha: 0.2).cgColor
        o.fillRule = .nonZero
        
        var textures: [SKTexture] = []
        
        for picture in pictures {
            if let (texture, scale) = picture.rendered {
                textures.append(texture)
                size = texture.size() / scale
            } else {
                do {
                    o.path = picture.path
                    let (texture, scale) = try o.skTexture(scale: scaleFactor)
                    size = texture.size() / scale
                    textures.append(texture)
                    picture.rendered = (texture, scale)
                } catch {
                    error.localizedDescription.peek("⚠️")
                    continue
                }
            }
        }
        guard textures.isEmpty.not else {
            "There were no textures to animate".peek("⚠️")
            return
        }
        self.textures = textures
        resetAnimation()
    }
}

@available(OSX 10.13, *)
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

@available(OSX 10.13, *)
extension SKShapeFlipNode.Picture {
    
    public convenience init(_ drawing: CGDrawing, _ style: CGShapeStyle = .init()) {
        self.init(drawing.path(), style)
    }
}
#endif
