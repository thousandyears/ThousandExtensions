@inlinable
@discardableResult
public func + <O>(l: O, r: [(O) -> O]) -> O {
    r.reduce(l){ l, r in r(l) }
}

@inlinable
public func == <O, P>(l: ReferenceWritableKeyPath<O, P>, r: P) -> (O) -> O {
    return { o in
        o[keyPath: l] = r
        return o
    }
}
