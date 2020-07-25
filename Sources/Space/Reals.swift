extension Sequence where Element: Real {
    
    @inlinable public func sum() -> Element {
        reduce(0, +)
    }
}

extension Collection where Element: Real {
    
    @inlinable public func mean() -> Element? {
        isEmpty ? nil : sum() / Element(count)
    }
    
    public func rms<Other>(with other: Other) -> Element
        where Other: Collection, Other.Element == Element
    {
        guard !isEmpty else { return Element.zero }
        let sum = zip(self, other).reduce(.zero){ $0 + ($1.0 - $1.1) * ($1.0 - $1.1) }
        let mean = sum / Element(count)
        return Element.sqrt(mean)
    }
}

extension Collection where Element: Real {
    
    public func minMax() -> (min: Element, max: Element)? {
        guard let first = first else { return nil }
        var min = first, max = first
        for e in dropFirst() {
            if e < min { min = e }
            else if e > max { max = e }
        }
        return (min, max)
    }

    public func scaledToSumOne() -> [Element]? {
        guard let (min, max) = minMax(), min < max else { return nil }
        let s = sum()
        guard s != 0 else { return nil }
        return map{ $0 / s }
    }
}
