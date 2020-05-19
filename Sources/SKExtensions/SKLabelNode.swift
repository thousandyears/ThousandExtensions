extension SKLabelNode {

    @available(OSX 10.13, iOS 11.0, *)
    @inlinable public func multiline(count: Int = 0) -> Self {
        numberOfLines = count
        return self
    }
}
