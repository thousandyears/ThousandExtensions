//
//  CGPoint.swift
//  
//
//  Created by Oliver Atkinson on 14/06/2020.
//

extension CGPoint {
    @inlinable public func clamped(to range: ClosedRange<CGFloat>) -> CGPoint {
        .init(x: x.clamped(to: range), y: y.clamped(to: range))
    }
    @inlinable public func rounded(to factor: CGFloat) -> CGPoint {
        .init(x: x.rounded(to: factor), y: y.rounded(to: factor))
    }
    public func scaled(to factor: CGFloat, anchoredTo point: CGPoint = .zero) -> CGPoint {
        self + (point - self) * (1 - factor)
    }
    public func scaled(to factor: CGSize, anchoredTo point: CGPoint = .zero) -> CGPoint {
        let offset = (point - self)
        let scale = (1 - factor)
        return self + offset * scale
    }
    @inlinable public init(xy: CGFloat) {
        self.init(x: xy, y: xy)
    }
}
