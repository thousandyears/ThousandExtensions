//
//  FloatingPoint.swift
//
//
//  Created by Oliver Atkinson on 17/05/2020.
//

extension FloatingPoint {
    @inlinable public func rounded(to factor: Self) -> Self {
        (self * factor).rounded() / factor
    }
}
