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

@IBDesignable
@objc(MKGradientView)
open class GradientView: UIView {
    @IBInspectable @available(*, unavailable, message: "This property is reserved for Interface Builder only.")
    public var gradientType: Int {
        set {
            type = GradientType(rawValue: newValue) ?? .linear
        }
        get {
            type.rawValue
        }
    }
    
    @IBInspectable @available(*, unavailable, message: "This property is reserved for Interface Builder only.")
    public var startColor: UIColor {
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
    
    @IBInspectable @available(*, unavailable, message: "This property is reserved for Interface Builder only.")
    public var endColor: UIColor {
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
    
    /// The array of colors defining the color of each gradient stop.
    /// For `.bilinear` gradient type defines X-direction gradient stops.
    open var colors: [UIColor] = [.clear, .clear] {
        didSet {
            gradientLayer.colors = colors.map { $0.cgColor }
        }
    }
    
    /// The array of Y-direction gradient stops for `.bilinear` gradient type.
    /// Ignored for other gradient types.
    open var colors2: [UIColor] = [.clear, .clear] {
        didSet {
            gradientLayer.colors2 = colors2.map { $0.cgColor }
        }
    }
    
    /// An optional array of Floats defining the location of each gradient stop as a value in the range [0.0, 1.0]. The values must be monotonically increasing. If a nil array is given, the stops are assumed to spread uniformly across the [0.0, 1.0] range. The number of elements must be equal to `colors` array count.
    /// Defines X-direction color locations for `.bilinear` gradient type.
    open var locations: [Float]? {
        didSet {
            gradientLayer.locations = locations
        }
    }
    
    /// An optional array of Y-direction color locations for `.bilinear` gradient type. The number of elements must be equal to `colors2` array count.
    /// Ignored for other gradient types.
    open var locations2: [Float]? {
        didSet {
            gradientLayer.locations2 = locations2
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
    @IBInspectable open var startPoint: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            gradientLayer.startPoint = startPoint
        }
    }
    
    /// The end point of the gradient when drawn into the layer's coordinate space. The end point corresponds to the last gradient stop. The points are defined in a unit coordinate space that is then mapped to the layer's bounds rectangle when drawn. (I.e. [0.0, 0.0] is the bottom-left corner of the layer, [1.0, 1.0] is the top-right corner.).
    @IBInspectable open var endPoint: CGPoint = CGPoint(x: 1, y: 1) {
        didSet {
            gradientLayer.endPoint = endPoint
        }
    }
    
    /// The start point of the `.bilinear` gradient's Y-direction, defaults to [0.5, 0.0] -> [0.5, 1.0].
    /// Ignored for other gradient types.
    open var startPoint2: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            gradientLayer.startPoint2 = startPoint2
        }
    }
    
    /// The end point of the `.bilinear` gradient's Y-direction, defaults to [0.5, 0.0] -> [0.5, 1.0].
    /// Ignored for other gradient types.
    open var endPoint2: CGPoint = CGPoint(x: 1, y: 1) {
        didSet {
            gradientLayer.endPoint2 = endPoint2
        }
    }
    
    /// Type of the gradient to be drawn.
    open var type: GradientType = .linear {
        didSet {
            gradientLayer.type = type
        }
    }
    
    private var gradientLayer: GradientLayer {
        return layer as! GradientLayer
    }
    
    open override class var layerClass: AnyClass {
        return GradientLayer.self
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        // layer.contentsScale = UIScreen.mainScreen().scale
        layer.needsDisplayOnBoundsChange = true
        layer.setNeedsDisplay()
    }
    
    open override func prepareForInterfaceBuilder() {
        // To improve IB performance, reduce generated image size
        layer.contentsScale = 0.25
    }
}
