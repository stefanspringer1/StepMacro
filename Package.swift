// swift-tools-version: 5.9

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "Steps",
    platforms: [.macOS(.v13), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        .library(
            name: "StepMacro",
            targets: ["StepMacro"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", from: "600.0.1"),
        //.package(url: "https://github.com/stefanspringer1/SwiftWorkflow", from: "3.0.0"),
        .package(path: "../SwiftWorkflow"),
    ],
    targets: [
        .macro(
            name: "StepMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                .product(name: "Workflow", package: "SwiftWorkflow"),
            ]
        ),
        .target(
            name: "StepMacro",
            dependencies: ["StepMacros"]
        ),
        .testTarget(
            name: "MacroTests",
            dependencies: [
                "StepMacro",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
                .product(name: "Workflow", package: "SwiftWorkflow"),
            ],
            swiftSettings: [
                .enableExperimentalFeature("BodyMacros"),
                .enableUpcomingFeature("ConciseMagicFile"),
                .enableUpcomingFeature("BareSlashRegexLiterals"),
            ]
        ),
    ]
)
