@available(OSX 10.13, iOS 11.0, *)
extension NSCoding where Self: NSObject {
    
    public func archivingBasedCopy() throws -> Self {
        let o = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
        return try NSKeyedUnarchiver.unarchivedObject(ofClass: Self.self, from: o).or()
    }
}
