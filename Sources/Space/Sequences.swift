extension Sequence {
    
    @inlinable public func min<A: Comparable>(by keyPath: KeyPath<Element, A>) -> Element? {
        self.min{ $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
    
    @inlinable public func max<A: Comparable>(by keyPath: KeyPath<Element, A>) -> Element? {
        self.max{ $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}

extension Collection where Indices == Range<Int> {
    
    @inlinable public func cycle(to index: Int) throws -> Element {
        try self[index.cycled(over: indices)]
    }
}

extension Collection where Indices == Range<Int> {
    
    public func neighbours(of index: Int, rows: Int, cols: Int) throws -> [Element] {
        try neighbourIndices(of: index, rows: rows, cols: cols).map{ self[$0] }
    }
    
    public func neighbourIndices(of index: Int, rows: Int, cols: Int) throws -> [Int] {
        guard indices ~= index else { throw "Expected indices ~= index, got: \(index), \(indices)".error() }
        guard rows > 0 else { throw "Expected rows > 0, got: \(rows)".error() }
        guard cols > 0 else { throw "Expected cols > 0, got: \(cols)".error() }
        guard rows * cols == count else { throw "rows * cols == count, got: \(rows), \(cols), \(count)".error() }
        let (row, col) = try index.inedexWhere(cols: cols)
        let o: [(row: Int, col: Int)] = [
            (row - 1, col - 1), // -, -
            (row - 0, col - 1), // ., -
            (row + 1, col - 1), // +, -
            (row - 1, col - 0), // -, .
            // (row - 0, col - 0), // ., .
            (row + 1, col - 0), // +, .
            (row - 1, col + 1), // -, +
            (row - 0, col + 1), // ., +
            (row + 1, col + 1), // +, +
        ]
        return o.compactMap{ try? cols.colsToIndex(row: $0, col: $1) }.filter{ indices ~= $0 }
    }
}
