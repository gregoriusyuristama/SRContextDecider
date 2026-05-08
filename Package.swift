// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "SRContextDecider",
    platforms: [.macOS(.v26)],
    products: [
        .library(name: "SRContextDecider", targets: ["SRContextDecider"]),
    ],
    dependencies: [
        .package(path: "../SRCore"),
    ],
    targets: [
        .target(
            name: "SRContextDecider",
            dependencies: ["SRCore"]
        ),
    ]
)
