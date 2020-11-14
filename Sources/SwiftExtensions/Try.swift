import Peek

public struct Try { // TODO: empty enum instead
    
    private let cases: [() throws -> ()]
    
    private init(_ cases: [() throws -> ()] = []) {
        self.cases = cases
    }
}

extension Try {
    
    public static var `switch`: Try { self.init() } // TODO: return TrySwitch instead (see TODO above)

    public func `case`(_ ƒ: @escaping () throws -> ()) -> Try {
        .init(cases + [ƒ])
    }
    
    public func `default`(
        function: String = #function,
        file: String = #file,
        line: Int = #line
    ) {
        var errors: [Error] = []
        for ƒ in cases {
            do { return try ƒ() }
            catch { errors.append(error) }
        }
        for error in errors {
            "\(error)".peek("⚠️", function: function, file: file, line: line)
        }
    }
    
    public func `default`(_ ƒ: ([Error]) -> ()) {
        var errors: [Error] = []
        for ƒ in cases {
            do { return try ƒ() }
            catch { errors.append(error) }
        }
        ƒ(errors)
    }
    
    public func defaultLast() throws {
        var error: Error?
        self.default{ error = $0.last }
        if let error = error {
            throw error
        }
    }
}
