extension SKScene {
    
    @discardableResult
    public func `in`(_ view: SKView, transition: SKTransition = .fade(withDuration: 1)) -> Self {
        view.presentScene(self, transition: transition)
        return self
    }
}
