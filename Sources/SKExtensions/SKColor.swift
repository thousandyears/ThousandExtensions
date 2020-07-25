extension SKColor {
    
    public typealias HSBA = (CGFloat, CGFloat, CGFloat, CGFloat)
    
    public var hsba: HSBA {
        var (h, s, b, a) = (0.cg, 0.cg, 0.cg, 0.cg)
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h, s, b, a)
    }
}

extension SKColor {
    
    @inlinable public static func + (l: SKColor, r: HSBA) -> SKColor {
        let (h, s, b, a) = l.hsba + r
        return .init(hue: h, saturation: s, brightness: b, alpha: a)
    }
    
    @inlinable public static func - (l: SKColor, r: HSBA) -> SKColor {
        let (h, s, b, a) = l.hsba - r
        return .init(hue: h, saturation: s, brightness: b, alpha: a)
    }
    
    @inlinable public static func * (l: SKColor, r: HSBA) -> SKColor {
        let (h, s, b, a) = l.hsba * r
        return .init(hue: h, saturation: s, brightness: b, alpha: a)
    }
    
    @inlinable public static func / (l: SKColor, r: HSBA) -> SKColor {
        let (h, s, b, a) = l.hsba / r
        return .init(hue: h, saturation: s, brightness: b, alpha: a)
    }
}

#if canImport(JavaScriptCore)
import JavaScriptCore

extension SKColor {
    
    public static func from(css: String) throws -> SKColor {
        if ["blank", "clear", "nil", "none", "transparent"].contains(css) {
            return .clear
        }
        let html = "<span style='color:\(css)'>█</span>"
        let data = try html.data(using: .utf8).or(throw: "Could not encode '\(css)'".error())
        let astr = try NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
        guard let ªcolor = astr.attribute(.foregroundColor, at: 0, effectiveRange: nil) else {
            throw "No background color found?".error()
        }
        return try (ªcolor as? SKColor).or(throw: "Could not convert '\(css)' to a color".error())
    }
}
#endif
