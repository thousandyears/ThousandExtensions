extension CGContext {
    
    @inlinable public static func rgb(width: Int, height: Int) throws -> CGContext {
        return try CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ).or(
            throw: "⚠️ Could not create CGContext(width: \(width), height: \(height)".error()
        )
    }
    
    @inlinable public static func rgb(preferredSize: CGSize) throws -> CGContext {
        let bounds = CGRect(origin: .zero, size: preferredSize).integral
        return try My.rgb(width: bounds.size.width.i, height: bounds.size.height.i)
    }
}

extension CGContext {
    @inlinable public var size: CGSize { .init(width: width.cg, height: height.cg) }
    @inlinable public var bounds: CGRect { .init(origin: .zero, size: size) }
}
