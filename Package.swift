// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Manga",
    platforms: [
       .macOS(.v10_14)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-beta"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0-beta"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.0.0-beta"),
        .package(url: "https://github.com/JohnSundell/Plot.git", from: "0.5.0")
    ],
    targets: [
        .target(name: "App", dependencies: [
            "Fluent", 
            "FluentPostgresDriver",
            "Vapor"
        ]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App", "XCTVapor"])
    ]
)