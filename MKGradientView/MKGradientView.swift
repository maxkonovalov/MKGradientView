/*
The MIT License (MIT)

Copyright (c) 2015 Max Konovalov

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

import UIKit

// MARK: - Gradient View

open class MKGradientView: UIView {
    
    open var colors: [UIColor] = [.clear, .clear] {
        didSet {
            (layer as! MKGradientLayer).colors = colors.map { $0.cgColor }
        }
    }
    
    open var colors2: [UIColor] = [.clear, .clear] {
        didSet {
            (layer as! MKGradientLayer).colors2 = colors2.map { $0.cgColor }
        }
    }
    
    open var locations: [Float]? {
        didSet {
            (layer as! MKGradientLayer).locations = locations
        }
    }
    
    @IBInspectable open var startPoint: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            (layer as! MKGradientLayer).startPoint = startPoint
        }
    }
    
    @IBInspectable open var endPoint: CGPoint = CGPoint(x: 1, y: 1) {
        didSet {
            (layer as! MKGradientLayer).endPoint = endPoint
        }
    }
    
    open var startPoint2: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            (layer as! MKGradientLayer).startPoint2 = startPoint2
        }
    }
    
    open var endPoint2: CGPoint = CGPoint(x: 1, y: 1) {
        didSet {
            (layer as! MKGradientLayer).endPoint2 = endPoint2
        }
    }
    
    open var type: GradientType = .linear {
        didSet {
            (layer as! MKGradientLayer).type = type
        }
    }
    
    
    override open class var layerClass : AnyClass {
        return MKGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup() {
        //layer.contentsScale = UIScreen.mainScreen().scale
        layer.needsDisplayOnBoundsChange = true
        layer.setNeedsDisplay()
    }
    
}


// MARK: Interface Builder Additions

@IBDesignable @available(*, unavailable, message : "This is reserved for Interface Builder")
extension MKGradientView {
    
    @IBInspectable public var gradientType: Int {
        set {
            if let type = GradientType(rawValue: newValue) {
                self.type = type
            }
        }
        get {
            return self.type.rawValue
        }
    }
    
    @IBInspectable public var startColor: UIColor {
        set {
            if colors.isEmpty {
                colors.append(newValue)
                colors.append(UIColor.clear)
            } else {
                colors[0] = newValue
            }
        }
        get {
            return (colors.count >= 1) ? colors[0] : UIColor.clear
        }
    }
    
    @IBInspectable public var endColor: UIColor {
        set {
            if colors.isEmpty {
                colors.append(UIColor.clear)
                colors.append(newValue)
            } else {
                colors[1] = newValue
            }
        }
        get {
            return (colors.count >= 2) ? colors[1] : UIColor.clear
        }
    }
    
    open override func prepareForInterfaceBuilder() {
        // To improve IB performance, reduce generated image size
        layer.contentsScale = 0.25
    }
    
}


// MARK: - Gradient Layer

open class MKGradientLayer: CALayer {
    
    /// The array of CGColorRef objects defining the color of each gradient stop.
    /// For `.bilinear` gradient type defines X-direction gradient stops.
    open var colors: [CGColor] = [UIColor.clear.cgColor, UIColor.clear.cgColor] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// The array of Y-direction gradient stops for `.bilinear` gradient type.
    /// Ignored for other gradient types.
    open var colors2: [CGColor] = [UIColor.clear.cgColor, UIColor.clear.cgColor] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// An optional array of Floats defining the location of each gradient stop as a value in the range [0.0, 1.0]. The values must be monotonically increasing. If a nil array is given, the stops are assumed to spread uniformly across the [0.0, 1.0] range. The number of elements must be equal to `colors` array count.
    /// Defines X-direction color locations for `.bilinear` gradient type.
    open var locations: [Float]? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// An optional array of Y-direction color locations for `.bilinear` gradient type. The number of elements must be equal to `colors2` array count. 
    /// Ignored for other gradient types.
    open var locations2: [Float]? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// The start point of the gradient when drawn into the layer's coordinate space. The start point corresponds to the first gradient stop. The points are defined in a unit coordinate space that is then mapped to the layer's bounds rectangle when drawn. (I.e. [0.0, 0.0] is the bottom-left corner of the layer, [1.0, 1.0] is the top-right corner.).
    ///
    /// The default values for gradient types are:
    ///
    /// - `.linear`:  [0.5, 0.0] -> [0.5, 1.0]
    /// - `.radial`:  [0.5, 0.5] -> [1.0, 0.5]
    /// - `.conical`: [0.5, 0.5] -> [1.0, 0.5]
    /// - `.bilinear` (X-direction): [0.0, 0.5] -> [1.0, 0.5]
    open var startPoint: CGPoint? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// The end point of the gradient when drawn into the layer's coordinate space. The end point corresponds to the last gradient stop. The points are defined in a unit coordinate space that is then mapped to the layer's bounds rectangle when drawn. (I.e. [0.0, 0.0] is the bottom-left corner of the layer, [1.0, 1.0] is the top-right corner.).
    open var endPoint: CGPoint? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// The start point of the `.bilinear` gradient's Y-direction, defaults to [0.5, 0.0] -> [0.5, 1.0].
    /// Ignored for other gradient types.
    open var startPoint2: CGPoint? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// The end point of the `.bilinear` gradient's Y-direction, defaults to [0.5, 0.0] -> [0.5, 1.0].
    /// Ignored for other gradient types.
    open var endPoint2: CGPoint? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// The kind of gradient that will be drawn.
    open var type: GradientType = .linear {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    // MARK: Content drawing
    
    override open func draw(in ctx: CGContext) {
        ctx.setFillColor(backgroundColor!)
        ctx.fill(bounds)
        
        let img = MKGradientGenerator.gradientImage(type: type, size: bounds.size, colors: colors, colors2: colors2, locations: locations, locations2: locations2, startPoint: startPoint, endPoint: endPoint, startPoint2: startPoint2, endPoint2: endPoint2, scale: contentsScale)
        ctx.draw(img, in: bounds)
    }
    
}
