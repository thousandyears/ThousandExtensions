extension CAGradientLayer {
    
    public var angle: CGFloat {
        get {
            startPoint.angle(to: endPoint)
        }
        set {
            let t = CGAffineTransform(rotateBy: newValue, around: .unit / 2)
            let axis = CGRect.unit.applying(t.inverted()).xAxis.applying(t)
            startPoint = axis.start
            endPoint = axis.end
        }
    }
}
