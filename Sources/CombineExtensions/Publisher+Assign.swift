//
//  File.swift
//  
//
//  Created by Oliver Atkinson on 20/05/2020.
//

#if canImport(Combine)

import Combine

public extension Publisher where Self.Failure == Never {
    
    func assign(_ assignments: Assign<Output>...) -> AnyCancellable {
        sink { value in
            for o in assignments {
                o.action(value)
            }
        }
    }

}

public struct Assign<Output> {
    
    public enum Ownership: String, Codable {
        case weak
        case strong
        case unowned
    }
    
    public var action: (Output) -> Void
    public init<Root>(keyPath: ReferenceWritableKeyPath<Root, Output>, on root: Root) {
        action = { root[keyPath: keyPath] = $0 }
    }
    
    public init<Root>(keyPath: ReferenceWritableKeyPath<Root, Output>, on root: Root, ownership: Ownership = .strong) where Root: AnyObject {
        switch ownership {
        case .strong:
            action = { [root] in root[keyPath: keyPath] = $0 }
        case .weak:
            action = { [weak root] in root?[keyPath: keyPath] = $0 }
        case .unowned:
            action = { [unowned root] in root[keyPath: keyPath] = $0 }
        }
    }
    
    public static func to<Root>(_ keyPath: ReferenceWritableKeyPath<Root, Output>, on root: Root) -> Assign<Output> {
        .init(keyPath: keyPath, on: root)
    }
    
    public static func to<Root>(
        _ keyPath: ReferenceWritableKeyPath<Root, Output>,
        on root: Root,
        ownership: Ownership = .strong
    ) -> Assign<Output> where Root: AnyObject {
        .init(keyPath: keyPath, on: root)
    }

}

#endif
