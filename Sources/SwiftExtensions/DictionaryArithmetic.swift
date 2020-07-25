extension Dictionary {
    @inlinable public static func + (l: Self, r: Self) -> Self { l.merging(r){ _, last in last } }
    @inlinable public static func += (l: inout Self, r: Self) { l.merge(r){ _, last in last } }
}

extension Dictionary where Value: AdditiveArithmetic {
    
    @inlinable public static func .+ (l: Self, r: Self) -> Self { l.merging(r, uniquingKeysWith: +) }
    @inlinable public static func .+= (l: inout Self, r: Self) { l.merge(r, uniquingKeysWith: +) }
    
    @inlinable public static func .- (l: Self, r: Self) -> Self { l.merging(r, uniquingKeysWith: -) }
    @inlinable public static func .-= (l: inout Self, r: Self) { l.merge(r, uniquingKeysWith: -) }
}

extension Dictionary where Value: AdditiveArithmetic {
    
    @inlinable public static func .+ (l: Self, r: Value) -> Self { l.mapValues{ $0 + r } }
    @inlinable public static func .+= (l: inout Self, r: Value) { l = l .+ r }

    @inlinable public static func .- (l: Self, r: Value) -> Self { l.mapValues{ $0 - r } }
    @inlinable public static func .-= (l: inout Self, r: Value) { l = l .- r }
}

extension Dictionary where Value: AlgebraicField {
    
    @inlinable public static func .* (l: Self, r: Self) -> Self { l.merging(r, uniquingKeysWith: *) }
    @inlinable public static func .*= (l: inout Self, r: Self) { l.merge(r, uniquingKeysWith: *) }

    @inlinable public static func ./ (l: Self, r: Self) -> Self { l.merging(r, uniquingKeysWith: /) }
    @inlinable public static func ./= (l: inout Self, r: Self) { l.merge(r, uniquingKeysWith: /) }
}

extension Dictionary where Value: AlgebraicField {
    
    @inlinable public static func .* (l: Self, r: Value) -> Self { l.mapValues{ $0 * r } }
    @inlinable public static func .*= (l: inout Self, r: Value) { l = l .* r }

    @inlinable public static func ./ (l: Self, r: Value) -> Self { l.mapValues{ $0 / r } }
    @inlinable public static func ./= (l: inout Self, r: Value) { l = l ./ r }
}
