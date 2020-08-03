extension Real2D where D == CGFloat {
    
    @inlinable public var lineSegment: CGLineSegment { .init(from: .zero, to: self.cast()) }
}
