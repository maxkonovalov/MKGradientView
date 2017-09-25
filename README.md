# MKGradientView

[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)

Highly customizable Core Graphics based gradient view

<img src="MKGradientView.png?raw=true" alt="MKGradientView" width=320>


## Features
#### Available gradient types:
- Linear (Axial)
- Radial (Circular)
- Conical (Angular)
- Bilinear (Four Point)

## Installation
Just add `MKGradientView.swift` and `MKGradientGenerator.swift` files to your Xcode project.

## Usage
See example Xcode project

### Interface Builder
Simple 2-color gradients can be set up in Storyboard.
You can specify `Gradient Type`, `Start Color`, `End Color`, `Start Point`, `End Point`.

### Code
```swift
let gradientView = MKGradientView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
gradientView.type = .linear
gradientView.colors = [.red, .green]
gradientView.locations = [0, 1]
gradientView.startPoint = CGPoint(x: 0, y: 0)
gradientView.endPoint = CGPoint(x: 1, y: 1)
view.addSubview(gradientView)
```
To set up a `Bilinear` gradient, you need to specify `colors2` array:

```swift
let gradientView = MKGradientView(frame: CGRect(x: 100, y: 0, width: 100, height: 100))
gradientView.type = .bilinear
gradientView.colors = [.red, .yellow]
gradientView.colors2 = [.blue, .cyan]
view.addSubview(gradientView)
```

## Performance
`MKGradientLayer` is image-backed, and the algorithm performance behind it highly depends on the size of the generated image. To speed it up, minimum possible layer size should be used. It can be adjusted with `MKGradientLayer`'s `contentsScale` property, `1.0` being an optimal value for performance/quality balance. Use lower values like `0.5` to speed up rendering time or set it equal to `UIScreen.mainScreen().scale` to get precise result.

Note that there also seems to be an isse with overall Swift performance compared to Objective-C and C implementation, especially in DEBUG builds. In that case, setting `Optimization Level` in Build Settings to `Fast [-O]` for Debug configuration should achieve better performance.

## Requirements
- iOS 8.0
- Xcode 9, Swift 4

## License
`MKGradientView` is available under the MIT license. See the LICENSE file for more info.
