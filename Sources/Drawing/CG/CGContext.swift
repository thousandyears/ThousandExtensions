extension CGContext: CGPencil {
    
    // TODO: rethink naming, since these `draw` methods only add paths
    
    public func draw(_ o: CGStroke) {
        move(to: o.start)
        for o in o.moves {
            switch o.count {
            case 1: addLine(to: o[0])
            case 2: addQuadCurve(to: o[0], control: o[1])
            case 3...: addCurve(to: o[0], control1: o[1], control2: o[2])
            default: continue
            }
        }
        if o.isClosed { closePath() }
    }
    
    public func draw(_ drawing: CGDrawing, using t: CGAffineTransform = .identity) {
        let o = CGMutablePath()
        o.addPath(drawing.path(), transform: t)
        addPath(o)
    }
    
    public func draw(_ o: CGPolygonalChain) {
        addLines(between: o.vertices)
        if !o.isEmpty, o.isClosed { closePath() }
    }
    
    public func draw(_ o: CGRect) {
        addRect(o)
    }
    
    public func draw(_ o: CGEllipse) {
        addEllipse(in: o.frame)
    }
}

extension CGContext {
    @inlinable public var size: CGSize { .init(width: width.cg, height: height.cg) }
    @inlinable public var bounds: CGRect { .init(origin: .zero, size: size) }
}

extension CGContext {
    
    @inlinable public static func rgb(
        size: CGSize,
        padding: CGFloat = 0,
        scale: CGFloat
    ) throws -> CGContext {
        try rgb(frame: size.rectangle(origin: .zero), padding: .init(square: padding), scale: scale)
    }
    
    @inlinable public static func rgb(
        size: CGSize,
        padding: CGSize,
        scale: CGFloat
    ) throws -> CGContext {
        return try rgb(frame: size.rectangle(origin: .zero), padding: padding, scale: scale)
    }
    
    @inlinable public static func rgb(
        frame: CGRect,
        padding: CGFloat = 0,
        scale: CGFloat
    ) throws -> CGContext {
        try rgb(frame: frame, padding: .init(square: padding), scale: scale)
    }
    
    @inlinable public static func rgb(
        frame: CGRect,
        padding: CGSize,
        scale: CGFloat
    ) throws -> CGContext {
        let bounds = CGRect(
            origin: .zero,
            size: (frame.size + padding * 2) * scale
        ).integral
        let o = try rgb(width: bounds.size.width.i, height: bounds.size.height.i)
        o.scaleBy(x: scale, y: scale)
        let t = padding - frame.origin
        o.translateBy(x: t.width, y: t.height)
        return o
    }

    @inlinable public static func rgb(width: Int, height: Int) throws -> CGContext {
        return try CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )
        .or(throw: "⚠️ Could not create CGContext(width: \(width), height: \(height)".error())
    }
}
