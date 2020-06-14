//
//  CGSize.swift
//  
//
//  Created by Oliver Atkinson on 14/06/2020.
//

extension CGSize {
    @inlinable public static func * (lhs: CGFloat, rhs: CGSize) -> CGSize { CGSize(width: lhs * rhs.width, height: lhs * rhs.height) }
    @inlinable public static func / (lhs: CGFloat, rhs: CGSize) -> CGSize { CGSize(width: lhs / rhs.width, height: lhs / rhs.height) }
    @inlinable public static func + (lhs: CGFloat, rhs: CGSize) -> CGSize { CGSize(width: lhs + rhs.width, height: lhs + rhs.height) }
    @inlinable public static func - (lhs: CGFloat, rhs: CGSize) -> CGSize { CGSize(width: lhs - rhs.width, height: lhs - rhs.height) }
}
