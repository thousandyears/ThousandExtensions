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

extension Publisher {
    
    @inlinable public func scan() -> AnyPublisher<(newValue: Output, oldValue: Output), Failure> {
        scan(count: 2)
            .map { ($0[1], $0[0]) }
            .eraseToAnyPublisher()
    }
    
    @inlinable public func scan(count: Int) -> AnyPublisher<[Output], Failure> {
        scan([]) { ($0 + [$1]).suffix(count) }
            .filter { $0.count == count }
            .eraseToAnyPublisher()
    }
}

extension Publisher where Failure == Never {

    @inlinable public func partition(by predicate: @escaping (Output) -> Bool) -> (yes: AnyPublisher<Output, Failure>, no: AnyPublisher<Output, Failure>) {
        let src = zip(map(predicate))
        return (
            yes: src.compactMap { $1 ? $0 : nil }.eraseToAnyPublisher(),
            no:  src.compactMap { $1 ? nil : $0 }.eraseToAnyPublisher()
        )
    }
}

extension Publisher {
    
    @inlinable public func zip<T>(_ other: T...) -> AnyPublisher<[Output], Failure> where T: Publisher, T.Output == Output, T.Failure == Failure {
        zip(other)
    }
    
    @inlinable public func zip<T>(_ others: T) -> AnyPublisher<[Output], Failure> where T: Collection, T.Element: Publisher, T.Element.Output == Output, T.Element.Failure == Failure {
        others.reduce(map{ [$0] }.eraseToAnyPublisher()) { publisher, next in
            publisher.zip(next).map { $0 + [$1] }.eraseToAnyPublisher()
        }
    }
}

extension Publisher where Output: Hashable {
    
    @inlinable public func unique() -> Publishers.Filter<Self> {
        var set = Set<Output>()
        return filter { set.insert($0).inserted }
    }
}
