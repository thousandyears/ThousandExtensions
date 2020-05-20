//
//  File.swift
//  
//
//  Created by Oliver Atkinson on 20/05/2020.
//

#if canImport(Combine)

import Combine

extension Publisher where Self.Failure == Never {
    
    public func assign(_ assignments: Assign<Output>...) -> AnyCancellable {
        sink { value in
            for o in assignments {
                o.action(value)
            }
        }
    }
    
    @inlinable public func assign<Root>(
        to keyPath: ReferenceWritableKeyPath<Root, Output>, on object: Root, ownership: Assign<Output>.Ownership = .weak
    ) -> AnyCancellable where Root: AnyObject {
        assign(
            .to(keyPath, on: object, ownership: ownership)
        )
    }
    
    @inlinable public func assign<Root1, Root2>(
        to  keyPath1: ReferenceWritableKeyPath<Root1, Output>, on object1: Root1, ownership ownership1: Assign<Output>.Ownership = .weak,
        and keyPath2: ReferenceWritableKeyPath<Root2, Output>, on object2: Root2, ownership ownership2: Assign<Output>.Ownership = .weak
    ) -> AnyCancellable where Root1: AnyObject, Root2: AnyObject {
        assign(
            .to(keyPath1, on: object1, ownership: ownership1),
            .to(keyPath2, on: object2, ownership: ownership2)
        )
    }
    
    @inlinable public func assign<Root1, Root2, Root3>(
        to  keyPath1: ReferenceWritableKeyPath<Root1, Output>, on object1: Root1, ownership ownership1: Assign<Output>.Ownership = .weak,
        and keyPath2: ReferenceWritableKeyPath<Root2, Output>, on object2: Root2, ownership ownership2: Assign<Output>.Ownership = .weak,
        and keyPath3: ReferenceWritableKeyPath<Root3, Output>, on object3: Root3, ownership ownership3: Assign<Output>.Ownership = .weak
    ) -> AnyCancellable where Root1: AnyObject, Root2: AnyObject, Root3: AnyObject {
        assign(
            .to(keyPath1, on: object1, ownership: ownership1),
            .to(keyPath2, on: object2, ownership: ownership2),
            .to(keyPath3, on: object3, ownership: ownership3)
        )
    }

}

public struct Assign<Output> {
    
    public enum Ownership: String, Codable {
        case weak
        case strong
        case unowned
    }
    
    public var action: (Output) -> Void
    
    public init<Root>(keyPath: ReferenceWritableKeyPath<Root, Output>, on object: Root) {
        action = { object[keyPath: keyPath] = $0 }
    }
    
    public init<Root>(
        keyPath: ReferenceWritableKeyPath<Root, Output>,
        on object: Root,
        ownership: Ownership = .strong
    ) where Root: AnyObject {
        switch ownership {
        case .strong:
            action = { [object] in object[keyPath: keyPath] = $0 }
        case .weak:
            action = { [weak object] in object?[keyPath: keyPath] = $0 }
        case .unowned:
            action = { [unowned object] in object[keyPath: keyPath] = $0 }
        }
    }
    
    @inlinable public static func to<Root>(
        _ keyPath: ReferenceWritableKeyPath<Root, Output>,
        on object: Root
    ) -> Assign<Output> {
        .init(keyPath: keyPath, on: object)
    }
    
    @inlinable public static func to<Root>(
        _ keyPath: ReferenceWritableKeyPath<Root, Output>,
        on object: Root,
        ownership: Ownership = .strong
    ) -> Assign<Output> where Root: AnyObject {
        .init(keyPath: keyPath, on: object)
    }

}

#endif
