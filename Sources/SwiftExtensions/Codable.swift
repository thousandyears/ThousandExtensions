//
//  Codable.swift
//  
//
//  Created by Oliver Atkinson on 29/08/2020.
//

import Foundation

extension Sequence where Element == CodingKey {
    public var prettyDescription: String {
        enumerated().map { offset, key in
            if let idx = key.intValue {
                return "[\(idx)]"
            } else {
                return (offset > 0 ? "." : "") + key.stringValue
            }
        }.joined()
    }
}

extension DecodingError.Context {
    public var codingPathDescription: String { codingPath.prettyDescription }
}

extension EncodingError.Context {
    public var codingPathDescription: String { codingPath.prettyDescription }
}
