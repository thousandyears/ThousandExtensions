extension SKShader {

    public convenience init(
        file path: String,
        in bundle: Bundle,
        uniforms: [SKUniform] = [],
        attributes: [SKAttribute] = []
    ) throws {
        guard
            let url = bundle.url(forResource: path, withExtension: nil),
            let source = try? String(contentsOf: url, encoding: .utf8)
        else {
            throw "Missing shader \(path) in bundle \(bundle)".error()
        }
        self.init(source: source)
        self.uniforms = uniforms
        self.attributes = attributes
    }
}
