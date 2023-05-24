// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "TableViewContent",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "TableViewContent", targets: ["TableViewContent"])
    ],
    targets: [
        .target(name: "TableViewContent", path: "TableViewContent/Classes"),
        .testTarget(name: "TableViewContentTest", dependencies: ["TableViewContent"])
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
