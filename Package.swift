// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "MKGradientView",
    platforms: [
        .iOS(.v8)
    ],
    products: [
        .library(
            name: "MKGradientView",
            targets: ["MKGradientView"]),
    ],
    targets: [
        .target(
            name: "MKGradientView",
            path: "MKGradientView")
        )
    ]
)
