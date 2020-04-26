extension SKLabelNode {

    @available(OSX 10.13, *)
    @inlinable public func multiline(count: Int = 0) -> Self {
        numberOfLines = count
        return self
    }
}
