extension URL {
    
    public func replacingExt(to ext: String) -> URL {
        var o = self
        o.deletePathExtension()
        o.appendPathExtension(ext)
        return o
    }
    
    public subscript(queryParam: String) -> String? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false)
            else { return nil }
        
        return components.queryItems?.first(where: { $0.name == queryParam })?.value
    }
}
