public enum Bundled {
    
    @propertyWrapper public class JSON<A: Decodable> {
        
        let name: String
        unowned let bundle: Bundle
        let decoder: JSONDecoder
        var value: A?
        
        public var wrappedValue: A {
            get {
                if let o = value { return o }
                let url = try! bundle.url(forResource: name, withExtension: "json").or()
                let data = try! Data(contentsOf: url)
                value = try! decoder.decode(A.self, from: data)
                return value!
            }
            set {
                value = newValue
            }
        }
        
        public init(
            _ name: String = "\(A.self)",
            in bundle: Bundle = .main,
            with decoder: JSONDecoder = .init()
        ) {
            self.name = name
            self.bundle = bundle
            self.decoder = decoder
        }
    }
}

