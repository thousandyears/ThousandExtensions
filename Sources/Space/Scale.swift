extension Scale {
    
    @inlinable public func linear(_ x: X) -> X {
        scale(x){ x in x }
    }
}

extension Scale where X: Real {
    
    @inlinable public func pow(_ x: X, exp: X = 2) -> X {
        scale(x){ x in X.pow(x, exp) }
    }
    
    @inlinable public func sin(_ x: X) -> X {
        scale(x){ x in X.sin((x - 0.5) * .pi) * 0.5 + 0.5}
    }
}

public struct Scale<X: BinaryFloatingPoint> {
    
    public var domain: [X] { didSet { update() } }
    public var domainUsed: [X] { map.map { $0.domain } }
    
    public var range: [X] { didSet { update() } }
    public var rangeUsed: [X] { map.map { $0.range } }
    
    public private(set) var map: [(domain: X, range: X)] = []
    
    public var inverse: Scale { return Scale(domain: range, range: domain) }
    
    public init(domain: [X], range: [X]) {
        self.domain = domain
        self.range = range
        update()
    }
    
    mutating func update() {
        map = zip(domain, range).sorted(by: <)
    }
    
    public func scale(_ x: X, _ f: (X) -> X) -> X {
        switch map.count
        {
        case 0:
            return x
            
        case 1:
            return map[0].domain - x + map[0].range
            
        default:
            if x <= map[0].domain { return map[0].range }
            var from = map[0]
            for to in map[1..<map.count] {
                if x < to.domain {
                    let y = f( (x - from.domain) / (to.domain - from.domain) )
                    return (1 - y) * from.range + y * to.range
                }
                from = to
            }
            return map.last!.range
        }
    }
}

