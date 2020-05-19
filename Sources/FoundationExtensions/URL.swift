extension URL {
    
    public func replacingExt(to ext: String) -> URL {
        var o = self
        o.deletePathExtension()
        o.appendPathExtension(ext)
        return o
    }
}
