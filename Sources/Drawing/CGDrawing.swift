public protocol CGDrawing: CustomPlaygroundDisplayConvertible, CustomDebugStringConvertible {
    func draw(with pencil: CGPencil)
}

extension CGDrawing {
    
    public var playgroundDescription: Any {
        #if canImport(AppKit)
        return path().playgroundDescription
        #else
        return debugDescription
        #endif
    }
}
