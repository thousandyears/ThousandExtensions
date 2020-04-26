#if canImport(AppKit)
    public typealias SKEvent = NSEvent
#elseif canImport(UIKit)
    public typealias SKEvent = UIEvent
#endif

#if os(macOS)

public enum KeyboardKey: UInt16 {
    case plus = 24
    case minus = 27
    case delete = 51
    case esc = 53
    case left = 123
    case right = 124
    case down = 125
    case up = 126
}

extension KeyboardKey {
    @inlinable public var code: UInt16 { rawValue }
}

extension KeyboardKey: CustomStringConvertible {
    public var description: String {
        switch self {
        case .delete: return "delete"
        case .down: return "down"
        case .esc: return "esc"
        case .left: return "left"
        case .minus: return "minus"
        case .plus: return "plus"
        case .right: return "right"
        case .up: return "up"
        }
    }
}

public struct KeyboardExpression: Hashable {
    
    public enum By {
        case code(UInt16)
        case string(String)
        case pattern(NSRegularExpression)
    }
    
    public var by: By
    public var modifierFlags: SKEvent.ModifierFlags
    
    public init(
        _ by: By,
        _ modifierFlags: SKEvent.ModifierFlags = []
    ) {
        self.by = by
        self.modifierFlags = modifierFlags
    }

    public func hash(into hasher: inout Hasher) {
        switch by {
        case let .code(code):
            hasher.combine("code")
            hasher.combine(code)
        case let .string(string):
            hasher.combine("string")
            hasher.combine(string)
        case let .pattern(pattern):
            hasher.combine("pattern")
            hasher.combine(pattern)
        }
        hasher.combine(modifierFlags.rawValue)
    }
    
    public static func == (lhs: KeyboardExpression, rhs: KeyboardExpression) -> Bool {
        guard lhs.modifierFlags == rhs.modifierFlags else { return false }
        switch (lhs.by, rhs.by) {
        case let (.code(l), .code(r)): return l == r
        case let (.string(l), .string(r)): return l == r
        case let (.pattern(l), .pattern(r)): return l == r
        case (.code, _), (.string, _), (.pattern, _): return false
        }
    }
}

extension Dictionary where Key == KeyboardExpression {
    
    public subscript(by: KeyboardExpression.By, flags: SKEvent.ModifierFlags) -> Value? {
        get { self[KeyboardExpression(by, flags)] }
        set { self[KeyboardExpression(by, flags)] = newValue }
    }
}
#endif
