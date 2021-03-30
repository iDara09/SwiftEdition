// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "SwiftEdition",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "SwiftEdition", targets: ["SwiftEdition"]),
        .library(name: "AutoLayoutEdition", targets: ["AutoLayoutEdition"]),
        .library(name: "ClosureEdition", targets: ["ClosureEdition"]),
        .library(name: "CombineEdition", targets: ["CombineEdition"]),
        .library(name: "InterfaceEdition", targets: ["InterfaceEdition"])
    ],
    targets: [
        .target(name: "SwiftEdition", dependencies: ["AutoLayoutEdition", "CombineEdition", "InterfaceEdition", "ClosureEdition"]),
        .target(name: "AutoLayoutEdition"),
        .target(name: "ClosureEdition"),
        .target(name: "CombineEdition"),
        .target(name: "InterfaceEdition", dependencies: ["AutoLayoutEdition", "CombineEdition", "ClosureEdition"]),
        .testTarget(name: "AutoLayoutEditionTests", dependencies: ["AutoLayoutEdition"]),
        .testTarget(name: "ClosureEditionTests", dependencies: ["ClosureEdition"]),
        .testTarget(name: "InterfaceEditionTests", dependencies: ["InterfaceEdition"]),
    ]
)
