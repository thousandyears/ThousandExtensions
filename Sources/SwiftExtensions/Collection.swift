extension Collection where Element: Equatable {
    
    public func count(of element: Element) -> Int {
        reduce(into: 0) { count, next in
            guard element == next else { return }
            count += 1
        }
    }
}

extension BidirectionalCollection where Element: Equatable {
    
    public func dropLast(_ element: Element) -> SubSequence {
        guard last == element else { return self[...] }
        return dropLast()
    }
}
