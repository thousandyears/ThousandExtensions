import Peek

extension BinaryInteger {
    @inlinable public var i: Int { Int(self) }
    @inlinable public var u: UInt { UInt(self) }
    @inlinable public var f: Float { Float(self) }
    @inlinable public var d: Double { Double(self) }
}

extension BinaryInteger {
    
    @inlinable public func element<C>(in c: C) throws -> C.Element where C: Collection, C.Indices == Range<Self> {
        guard c.indices ~= self else { throw "Index \(self) out of bounds \(c.indices)".error() }
        return c[self]
    }
}

extension BinaryInteger {
    
    @inlinable public func inedexWhere(cols: Self) throws -> (row: Self, col: Self) {
        guard self >= 0 else { throw "Expected self >= 0, got: \(self)".error() }
        guard cols > 0 else { throw "Expected cols > 0, got: \(cols)".error() }
        return (self / cols, self % cols)
    }
    
    @inlinable public func inedexWhere(rows: Self) throws -> (row: Self, col: Self) {
        guard self >= 0 else { throw "Expected self >= 0, got: \(self)".error() }
        guard rows > 0 else { throw "Expected rows > 0, got: \(rows)".error() }
        return (self % rows, self / rows)
    }
    
    @inlinable public func rowsToIndex(row: Self, col: Self) throws -> Self {
        guard self >= 0 else { throw "Expected self > 0, got: \(self)".error() }
        guard row >= 0 else { throw "Expected row >= 0, got: \(row)".error() }
        guard col >= 0 else { throw "Expected col >= 0, got: \(col)".error() }
        return self * col + row
    }
    
    @inlinable public func colsToIndex(row: Self, col: Self) throws -> Self {
        guard self >= 0 else { throw "Expected self > 0, got: \(self)".error() }
        guard row >= 0 else { throw "Expected row >= 0, got: \(row)".error() }
        guard col >= 0 else { throw "Expected col >= 0, got: \(col)".error() }
        return self * row + col
    }
}

extension SignedInteger {
    
    public func cycled(by offset: Self = 0, over range: Range<Self>) throws -> Self {
        guard !range.isEmpty else { throw "Range \(self) is empty".error() }
        let d = self % (range.upperBound - range.lowerBound)
        return d < 0 ? range.upperBound + d : range.lowerBound + d
    }
    
    @inlinable public mutating func cycle(by offset: Self, over range: Range<Self>) throws {
        try self = cycled(by: offset, over: range)
    }

    @inlinable public func cycledElement<C>(in c: C) throws -> C.Element where C: Collection, C.Indices == Range<Self> {
        try c[cycled(over: c.indices)]
    }
}
