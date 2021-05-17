extension SKShader {

    public convenience init(
        file path: String,
        in bundle: Bundle,
        uniforms: [SKUniform] = [],
        attributes: [SKAttribute] = [],
        prefix: String = ""
    ) throws {
        guard
            let url = bundle.url(forResource: path, withExtension: nil),
            let source = try? String(contentsOf: url, encoding: .utf8)
        else {
            throw "Missing shader \(path) in bundle \(bundle)".error()
        }
        self.init(source: "\(prefix)\n\(source)")
        self.uniforms = uniforms
        self.attributes = attributes
    }

    public convenience init(
        file path: String,
        in bundle: Bundle,
        uniforms: [SKUniform] = [],
        attributes: [SKAttribute] = [],
        defines: [String: Any]
    ) throws {
        let prefix = defines
            .map{ "#define \($0.key) \($0.value)" }
            .sorted()
            .joined(separator: "\n")
            + "\n"
        try self.init(file: path, in: bundle, uniforms: uniforms, attributes: attributes, prefix: prefix)
    }
}
