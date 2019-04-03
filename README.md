# MKGradientView

[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)
[![Platform](https://img.shields.io/cocoapods/p/MKGradientView.svg?style=flat)](http://cocoapods.org/pods/MKGradientView)
[![License](https://img.shields.io/cocoapods/l/MKGradientView.svg?style=flat)](http://cocoapods.org/pods/MKGradientView)
[![Version](https://img.shields.io/cocoapods/v/MKGradientView.svg?style=flat)](http://cocoapods.org/pods/MKGradientView)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Highly customizable Core Graphics based gradient view

<img src="MKGradientView.png?raw=true" alt="MKGradientView" width=320>


## Features
#### Available gradient types:
- Linear (Axial)
- Radial (Circular)
- Conical (Angular)
- Bilinear (Four Point)

## Installation
### CocoaPods

To install `MKGradientView` via [CocoaPods](http://cocoapods.org), add the following line to your Podfile:

```
pod 'MKGradientView'
```

### Carthage

To install `MKGradientView` via [Carthage](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos), add the following line to your Cartfile:

```
github "maxkonovalov/MKGradientView"
```

## Usage
See example Xcode project

### Interface Builder
Simple 2-color gradients can be set up in Interface Builder. Set your view's custom class to `MKGradientView`.

You can specify the following custom inspectable properties: 
- `Gradient Type`
- `Start Color`
- `End Color`
- `Start Point`
- `End Point`

### Code
```swift
let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
gradientView.type = .linear
gradientView.colors = [.red, .green]
gradientView.locations = [0, 1]
gradientView.startPoint = CGPoint(x: 0, y: 0)
gradientView.endPoint = CGPoint(x: 1, y: 1)
view.addSubview(gradientView)
```
To set up a `Bilinear` gradient, you need to specify `colors2` array:

```swift
let gradientView = GradientView(frame: CGRect(x: 100, y: 0, width: 100, height: 100))
gradientView.type = .bilinear
gradientView.colors = [.red, .yellow]
gradientView.colors2 = [.blue, .cyan]
view.addSubview(gradientView)
```

## Performance
`GradientLayer` is image-backed, and the algorithm performance behind it highly depends on the size of the generated image. To speed it up, minimum possible layer size should be used. It can be adjusted with `GradientLayer`'s `contentsScale` property, `1.0` being an optimal value for performance/quality balance. Use lower values like `0.5` to speed up rendering time or set it equal to `UIScreen.main.scale` to get precise result.


## Requirements
- iOS 8.0
- Xcode 10, Swift 4+

## License
`MKGradientView` is available under the MIT license. See the LICENSE file for more info.
