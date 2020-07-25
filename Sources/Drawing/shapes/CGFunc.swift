public struct CGFunc { // TODO: an AdditiveArithmetic protocol instead! - see Milos/Fun.swift
    public var plane: Plane
    public var scale: CGFloat
    public var stride: CGFloat
    public var range: ClosedRange<CGFloat>
    public var ƒ: (CGFloat) throws -> CGFloat?
}

extension CGFunc {
    
    public enum Plane: String, Codable, Equatable {
        case cartesian
        case polar
    }
}

extension CGFunc {
    
    public init(
        _ plane: Plane = .cartesian,
        scale: CGFloat = 1,
        stride: CGFloat = 1,
        over range: ClosedRange<CGFloat>,
        ƒ: @escaping (CGFloat) throws -> CGFloat?
    ) {
        precondition(stride > 0)
        self.plane = plane
        self.scale = scale
        self.stride = stride
        self.range = range
        self.ƒ = ƒ
    }
}

extension CGFunc {
    
    public static func * (l: CGFloat, r: CGFunc) -> CGFunc {
        self.init(
            plane: r.plane,
            scale: r.scale,
            stride: r.stride,
            range: r.range,
            ƒ: { x in try r.ƒ(x).map{ l * $0 } }
        )
    }
    
    public static func + (l: CGFunc, r: CGFunc) -> CGFunc {
        self.init(
            plane: l.plane,
            scale: (l.scale + r.scale) / 2,
            stride: (l.stride + r.stride) / 2,
            range: min(l.range.lowerBound, r.range.lowerBound) ... max(l.range.upperBound, r.range.upperBound),
            ƒ: { x in try r.ƒ(x).flatMap{ ry in try l.ƒ(x).map{ ly in ly + ry } } }
        )
    }
}

// MARK: - drawing

extension CGFunc {
    
    public func poligon(
        stride: CGFloat? = nil,
        closed: Bool = false
    ) throws -> CGPolygonalChain {
        let stride = stride ?? self.stride
        precondition(stride > 0)
        let x = Swift.stride(
            from: range.lowerBound,
            through: range.upperBound,
            by: stride
        )
        let points: [CGPoint] = try x.compactMap{ x in
            guard let y = try ƒ(x), y.isFinite else {
                return nil
            }
            switch plane {
            case .cartesian: return CGPoint(x: x, y: y) * scale
            case .polar: return CGPoint(x: y * x.cos(), y: y * x.sin()) * scale
            }
        }
        return CGPolygonalChain(vertices: points, closed: closed)
    }
}

extension CGFunc: CGDrawing {
    
    @inlinable public func draw(with pencil: CGPencil) {
        _ = try? pencil.draw(poligon())
    }
    
    @inlinable public var debugDescription: String {
        "\(CGFunc.self)(plane: \(plane), scale: \(scale), stride: \(stride), range: \(range))"
    }
}

/*
 See:
 CGFunction.init(
     info: UnsafeMutableRawPointer?,
     domainDimension: Int,
     domain: UnsafePointer<CGFloat>?,
     rangeDimension: Int,
     range: UnsafePointer<CGFloat>?,
     callbacks: UnsafePointer<CGFunctionCallbacks>
 )
 */
