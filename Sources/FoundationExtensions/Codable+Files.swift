extension Encodable where Self: Decodable {
    
    public static func dir(
        for directory: FileManager.SearchPathDirectory = .downloadsDirectory,
        in domain: FileManager.SearchPathDomainMask = .userDomainMask,
        appropriateFor url: URL? = nil,
        create shouldCreate: Bool = false
    ) throws -> URL {
        try FileManager.default
            .url(for: directory, in: domain, appropriateFor: url, create: shouldCreate)
            .appendingPathComponent("/")
    }
    
    public static func defaultFileName(ext: String = "json") -> String {
        "\(Self.self) \(Date()) \(Calendar.current.component(.nanosecond, from: .init())).\(ext)"
    }
    
    public static func defaultFileURL(
        ext: String = "json",
        for directory: FileManager.SearchPathDirectory = .downloadsDirectory,
        in domain: FileManager.SearchPathDomainMask = .userDomainMask,
        appropriateFor url: URL? = nil,
        create shouldCreate: Bool = false
    ) throws -> URL {
        try Self.dir(for: directory, in: domain, appropriateFor: url, create: shouldCreate)
            .appendingPathComponent(Self.defaultFileName(ext: ext))
    }

    public static func urls(
        for directory: FileManager.SearchPathDirectory = .downloadsDirectory,
        in domain: FileManager.SearchPathDomainMask = .userDomainMask,
        appropriateFor url: URL? = nil,
        create shouldCreate: Bool = false
    ) throws -> [URL] {
        let urls = try FileManager.default.contentsOfDirectory(
            at: dir(for: directory, in: domain, appropriateFor: url, create: shouldCreate),
            includingPropertiesForKeys: nil,
            options: .skipsHiddenFiles
        )
        return urls.filter{ url in
            let name = url.lastPathComponent
            return name.hasPrefix("\(Self.self)") && url.pathExtension == "json"
        }
    }
    
    public static func open(_ url: URL) throws -> Self {
        let data = try Data.init(contentsOf: url, options: [])
        return try JSONDecoder().decode(Self.self, from: data)
    }
    
    public static func open(
        for directory: FileManager.SearchPathDirectory = .downloadsDirectory,
        in domain: FileManager.SearchPathDomainMask = .userDomainMask,
        appropriateFor url: URL? = nil,
        create shouldCreate: Bool = false,
        error handler: @escaping (Error) -> () = {_ in}
    ) throws -> UnfoldSequence<Self, Int> {
        let urls = try self.urls(for: directory, in: domain, appropriateFor: url, create: shouldCreate)
        return sequence(state: 0) { i -> Self? in
            guard urls.indices ~= i else { return nil }
            defer { i += 1 }
            do {
                let data = try Data.init(contentsOf: urls[i], options: [])
                return try JSONDecoder().decode(Self.self, from: data)
            } catch {
                handler(error)
                return nil
            }
        }
    }
    
    public func save(
        formatting: JSONEncoder.OutputFormatting = [],
        ext: String = "json",
        for directory: FileManager.SearchPathDirectory = .downloadsDirectory,
        in domain: FileManager.SearchPathDomainMask = .userDomainMask,
        appropriateFor url: URL? = nil,
        create shouldCreate: Bool = false
    ) throws -> URL {
        let url = try Self.defaultFileURL(ext: ext, for: directory, in: domain, appropriateFor: url, create: shouldCreate)
        let encoder = JSONEncoder()
        encoder.outputFormatting = formatting
        let data = try encoder.encode(self)
        let json = try String(data: data, encoding: .utf8).or(throw: "Failed to encode data".error())
        try json.write(to: url, atomically: true, encoding: .utf8)
        return url
    }
}

