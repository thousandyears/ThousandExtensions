extension String {
    
    public static func * (l: String, r: Int) -> String {
        repeatElement(l, count: r).joined()
    }
    
    public func titlecase() -> String {
      return prefix(1).uppercased() + lowercased().dropFirst()
    }
}
