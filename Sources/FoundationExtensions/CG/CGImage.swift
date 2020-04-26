extension CGImage {
    
    @discardableResult
    public func write(to url: URL) -> Bool {
        guard let destination = CGImageDestinationCreateWithURL(url as CFURL, kUTTypePNG, 1, nil) else { return false }
        CGImageDestinationAddImage(destination, self, nil)
        return CGImageDestinationFinalize(destination)
    }
}
