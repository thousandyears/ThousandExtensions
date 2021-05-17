#if canImport(AppKit) // TODO: find a better home for these extensions
import AppKit

public typealias Pasteboard = NSPasteboard

extension Pasteboard {
    
    @inlinable
    public static func paste<A: Decodable>(_: A.Type = A.self, using decoder: JSONDecoder = .init()) throws -> A {
        try general.paste(using: decoder)
    }
    
    public func paste<A: Decodable>(_: A.Type = A.self, using decoder: JSONDecoder = .init()) throws -> A {
        let json = try paste(.string).or(throw: "No text found in the clipboard".error())
        let data = try json.data(using: .utf8).or(throw: "Could not blob text: \(json)".error())
        return try decoder.decode(A.self, from: data)
    }
    
    @inlinable
    public static func copy<A: Encodable>(_ a: A, using encoder: JSONEncoder = .init()) throws {
        try general.copy(a, using: encoder)
    }

    public func copy<A: Encodable>(_ a: A, using encoder: JSONEncoder = .init()) throws {
        encoder.outputFormatting.insert(.sortedKeys)
        let data = try encoder.encode(a)
        let json = try String(data: data, encoding: .utf8).or()
        copy(json)
    }
}

extension Pasteboard {
    
    public enum PasteType {
        
        case string
        
        var classes: [AnyClass] {
            switch self {
            case .string: return [NSString.self]
            }
        }
    }
    
    @inlinable
    public static func copy(_ string: String) {
        general.copy(string)
    }

    public func copy(_ string: String) {
        clearContents()
        writeObjects([string as NSString])
    }
    
    @inlinable
    public static func paste(_ type: PasteType) -> String? {
        general.paste(type)
    }

    public func paste(_ type: PasteType) -> String? {
        readObjects(forClasses: type.classes, options: nil)?.first as? String
    }
}
#endif
