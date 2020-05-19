import Cocoa

extension NSControl {
    public func addTarget(_ target: AnyObject, action: Selector) {
        self.target = target
        self.action = action
    }
}
