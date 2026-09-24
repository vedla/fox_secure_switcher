// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "fox_secure_switcher",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "fox-secure-switcher",
            targets: ["fox_secure_switcher"]
        )
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "fox_secure_switcher",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ]
        )
    ]
)