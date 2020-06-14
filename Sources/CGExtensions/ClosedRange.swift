//
//  ClosedRange.swift
//  
//
//  Created by Oliver Atkinson on 14/06/2020.
//

extension ClosedRange where Bound: FloatingPoint {
    public var middle: Bound { (lowerBound + upperBound) / 2 }
}

extension ClosedRange where Bound == CGFloat {
    public var frame: CGRect {
        CGRect(
            origin: CGPoint(x: lowerBound, y: lowerBound),
            size: CGSize(width: upperBound - lowerBound, height: upperBound - lowerBound)
        )
    }
}
