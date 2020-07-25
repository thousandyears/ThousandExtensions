@_exported import XCTest

infix operator ± : RangeFormationPrecedence

public typealias hope = Test

public struct Test<T> {
    public let value: () throws -> T
    public let file: StaticString
    public let line: UInt
}

extension Test {
    
    public init(
        _ value: @escaping @autoclosure () throws -> T,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        self.value = value
        self.file = file
        self.line = line
    }
}

extension Test where T: Equatable {
    
    @inlinable
    public static func == (l: Test, r: @autoclosure () throws -> T) {
        XCTAssertEqual(try l.value(), try r(), file: l.file, line: l.line)
    }
    
    @inlinable
    public static func != (l: Test, r: @autoclosure () throws -> T) {
        XCTAssertNotEqual(try l.value(), try r(), file: l.file, line: l.line)
    }
}

extension Test where T: Comparable {
    
    @inlinable
    public static func > (l: Test, r: @autoclosure () throws -> T) {
        XCTAssertGreaterThan(try l.value(), try r(), file: l.file, line: l.line)
    }
    
    @inlinable
    public static func < (l: Test, r: @autoclosure () throws -> T) {
        XCTAssertLessThan(try l.value(), try r(), file: l.file, line: l.line)
    }
    
    @inlinable
    public static func >= (l: Test, r: @autoclosure () throws -> T) {
        XCTAssertGreaterThanOrEqual(try l.value(), try r(), file: l.file, line: l.line)
    }
    
    @inlinable
    public static func <= (l: Test, r: @autoclosure () throws -> T) {
        XCTAssertLessThanOrEqual(try l.value(), try r(), file: l.file, line: l.line)
    }
}

extension Test where T: FloatingPoint {
    
    @inlinable
    public static func ~= (l: Test<T>, r: ClosedRange<T>) {
        let e = (r.upperBound - r.lowerBound) / 2
        XCTAssertEqual(try l.value(), r.lowerBound + e, accuracy: e, file: l.file, line: l.line)
    }
}

extension FloatingPoint {
    
    @inlinable public static func ± (l: Self, r: Self) -> ClosedRange<Self> {
        (l - abs(r)) ... (l + abs(r))
    }
}
