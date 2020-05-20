extension URL {
    
    public func replacingExt(to ext: String) -> URL {
        var o = self
        o.deletePathExtension()
        o.appendPathExtension(ext)
        return o
    }
}

extension String {
    public var url: URL? {
        return URL(string: self)
    }
}
