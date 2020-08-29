@_exported import Combine

extension Publisher where Self.Failure == Never {
    
    @inlinable public func sink<Root: AnyObject>(
        to method: @escaping (Root) -> (Output) -> (),
        on root: Root
    ) -> AnyCancellable {
        sink{ [weak root] output in
            guard let root = root else { return }
            method(root)(output)
        }
    }
    
    @inlinable public func sink<Root>(
        to keyPath: ReferenceWritableKeyPath<Root, Output>,
        on root: Root
    ) -> AnyCancellable {
        assign(to: keyPath, on: root)
    }
}

extension Publisher {
    
    @inlinable public func filter<Root: AnyObject>(while root: Root, _ keyPath: KeyPath<Root, Bool>) -> Publishers.Filter<Self> {
        filter{ [weak root] _ in root?[keyPath: keyPath] ?? false }
    }
    
    @inlinable public func reducing<A>(_ initialResult: A, _ ƒ: @escaping (A, Output) -> A) -> AnyPublisher<A, Failure> {
        var a = initialResult
        return map{ o -> A in a = ƒ(a, o); return a }.eraseToAnyPublisher()
    }
    
    @inlinable public func void() -> Publishers.Map<Self, ()> {
        map{ _ in () }
    }
}

import SwiftExtensions

extension Publisher where Failure == Never {
    
    @inlinable public func scanPrevious(_ oldValue: Output) -> Publishers.Scan<Self, (newValue: Output, oldValue: Output)> {
        scan((newValue: oldValue, oldValue: oldValue), { ($1, $0.newValue) })
    }
}

extension Publisher where Output: OptionalProtocol, Failure == Never {
    
    @inlinable public func scanPrevious(_ oldValue: Output = nil) -> Publishers.Scan<Self, (newValue: Output, oldValue: Output)> {
        scan((newValue: oldValue, oldValue: oldValue), { ($1, $0.newValue) })
    }
}

extension Publisher {
    
    @inlinable public func zip<T>(_ other: T...) -> AnyPublisher<[Output], Failure> where T: Publisher, T.Output == Output, T.Failure == Failure {
        zip(other)
    }
    
    @inlinable public func zip<T>(_ others: T) -> AnyPublisher<[Output], Failure> where T: Collection, T.Element: Publisher, T.Element.Output == Output, T.Element.Failure == Failure {
        others.reduce(map{ [$0] }.eraseToAnyPublisher()) { publisher, next in
            publisher.zip(next).map { all, next in all + [next] }.eraseToAnyPublisher()
        }
    }
}

extension Publisher where Output: Hashable {
    
    @inlinable public func unique() -> Publishers.Filter<Self> {
        var set = Set<Output>()
        return filter { set.insert($0).inserted }
    }
}
