//
//  SnappingCoordinateSystem.swift
//  
//
//  Created by Oliver Atkinson on 14/06/2020.
//

import Foundation

public protocol SnappingCoordinateSystem {
    var range: ClosedRange<CGFloat> { get }
    var tolerance: CGFloat { get }
}

extension CGPoint {

    public func rounded(to every: CGFloat, in range: ClosedRange<CGFloat>, radius: CGSize) -> CGPoint {
        scaled(to: 1 / radius, anchoredTo: CGPoint(xy: range.middle))
            .rounded(to: every)
            .clamped(to: range)
            .scaled(to: radius, anchoredTo: .init(xy: range.middle))
    }
    
    public func rounded(in coordinateSystem: SnappingCoordinateSystem, radius: CGSize) -> CGPoint {
        rounded(to: coordinateSystem.tolerance, in: coordinateSystem.range, radius: radius)
    }
    
}

extension SnappingCoordinateSystem {

    public subscript(x x: Int, y y: Int) -> CGRect {
        let t = tolerance.reciprocal
        return CGRect(
            origin: CGPoint(
                x: t * x.cg,
                y: t * y.cg
            ),
            size: CGSize(
                square: t
            )
        )
    }
    
    public func easting(at easting: CGFloat) -> CGLineSegment {
        CGLineSegment(
            from: CGPoint(x: range.lowerBound, y: easting),
            to: CGPoint(x: range.upperBound, y: easting)
        )
    }
    
    public func northing(at northing: CGFloat) -> CGLineSegment {
        CGLineSegment(
            from: CGPoint(x: northing, y: range.lowerBound),
            to: CGPoint(x: northing, y: range.upperBound)
        )
    }
    
}
