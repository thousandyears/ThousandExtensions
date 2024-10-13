//
//  Dictionary.swift
//  
//
//  Created by Oliver Atkinson on 14/05/2021.
//

extension Dictionary {
    
    public func compactMapKeys<T>(_ transform: (Key) throws -> T?) rethrows -> [T: Value] {
        return try reduce(into: [:]) { result, dictionary in
            guard let key = try transform(dictionary.key) else { return }
            result[key] = dictionary.value
        }
    }
    
    public func mapKeys<T>(_ transform: (Key) throws -> T) rethrows -> [T: Value] {
        return try reduce(into: [:]) { result, dictionary in
            result[try transform(dictionary.key)] = dictionary.value
        }
    }
}
