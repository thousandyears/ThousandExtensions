extension Array: CGDrawing, CustomPlaygroundDisplayConvertible where Element == CGDrawing {

    @inlinable public var drawing: CGDrawing { self }
    
    @inlinable public func draw(with pencil: CGPencil) {
        reversed().forEach{ $0.draw(with: pencil) }
    }
}

public func + (l: CGDrawing, r: CGDrawing) -> [CGDrawing] {
    switch (l, r) {
    case let (l as [CGDrawing], r as [CGDrawing]): return [l, r]
    case let (l as [CGDrawing], r): return l + [r]
    case let (l, r as [CGDrawing]): return [l] + r
    case let (l, r): return [l, r]
    }
}

@inlinable public func + <L, R>(l: L, r: R) -> CGDrawing where L: CGDrawing, R: CGDrawing {
    l as CGDrawing + r as CGDrawing
}

@inlinable public func + <L>(l: L, r: CGDrawing) -> CGDrawing where L: CGDrawing {
    l as CGDrawing + r
}

@inlinable public func + <R>(l: CGDrawing, r: R) -> CGDrawing where R: CGDrawing {
    l + r as CGDrawing
}
