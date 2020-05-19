extension String {
    
    public static func * (l: String, r: Int) -> String {
        repeatElement(l, count: r).joined()
    }
}
