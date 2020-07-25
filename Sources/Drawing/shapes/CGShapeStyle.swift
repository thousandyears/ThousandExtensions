public struct CGShapeStyle: Codable, Equatable {
    
    public var stroke: CGStrokeStyle = .init()
    public var fill: CGFillStyle = .init()
    
    public init() {}
}

public struct CGStrokeStyle: Codable, Equatable {

    public var lineWidth: CGFloat = 1
    //public var lineCap: CGLineCap = .round // TODO: make Coodable
    //public var lineJoin: CGLineJoin = .round // TODO: make Coodable
    
    public var miterLimit: CGFloat = 10
    
    public var dash: [CGFloat] = []
    public var dashPhase: CGFloat = 0
    
    public var glowWidth: CGFloat = 0

    public init() {}
}

public struct CGFillStyle: Codable, Equatable {

    public var isEOFilled: Bool = false
    
    public var alpha: CGFloat = 0.2

    public init() {}
}

