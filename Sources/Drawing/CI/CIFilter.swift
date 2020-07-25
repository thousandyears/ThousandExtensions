#if canImport(QuartzCore)

extension CIFilter {
    
    public enum Blur: String {
        case BoxBlur = "CIBoxBlur"
        // case DiscBlur = "CIDiscBlur"
        case GaussianBlur = "CIGaussianBlur"
        // case MaskedVariableBlur = "CIMaskedVariableBlur"
        // case MedianFilter = "CIMedianFilter"
        // case MotionBlur = "CIMotionBlur"
        // case NoiseReduction = "CINoiseReduction"
        // case ZoomBlur = "CIZoomBlur"
    }
    
    public static func blur(using type: Blur = .GaussianBlur, radius: CGFloat) throws -> CIFilter {
        try CIFilter(name: type.rawValue, parameters: ["inputRadius": radius])
            .or(throw: "⚠️ Could not create CI\(type.rawValue)(inputRadius: \(radius))".error())
    }
}
#endif
