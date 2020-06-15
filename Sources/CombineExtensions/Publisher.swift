//
//  Publisher+Previous.swift
//  
//
//  Created by Oliver Atkinson on 14/06/2020.
//

import Periscope
import FoundationExtensions

extension Publisher where Failure == Never {
    
    @inlinable public func sink<Root: AnyObject, T>(
        to method: @escaping (Root) -> (T, T) -> Void,
        on root: Root
    ) -> AnyCancellable where Output == (newValue: T, oldValue: T) {
        sink{ [weak root] output in
            root.map(method)?(output.newValue, output.oldValue)
        }
    }
    
}

extension Publisher where Failure == Never {
    
    @inlinable public func previous(_ oldValue: Output) -> Publishers.Scan<Self, (newValue: Output, oldValue: Output)> {
        scan((newValue: oldValue, oldValue: oldValue), { ($1, $0.newValue) })
    }
    
}
