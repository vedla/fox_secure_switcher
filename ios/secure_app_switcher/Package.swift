// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "secure_app_switcher",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "secure-app-switcher",
            targets: ["secure_app_switcher"]
        )
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "secure_app_switcher",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ]
        )
    ]
)