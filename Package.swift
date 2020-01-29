// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "UserDefaultsKey",
    products: [
        .library(name: "UserDefaultsKey", targets: ["UserDefaultsKey"]),
    ],
    targets: [
        .target(name: "UserDefaultsKey"),
        .testTarget(name: "UserDefaultsKeyTests", dependencies: ["UserDefaultsKey"]),
    ]
)
