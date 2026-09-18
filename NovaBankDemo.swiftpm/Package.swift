// swift-tools-version: 5.9
import PackageDescription
import AppleProductTypes

let package = Package(
    name: "IntesaSanpaolo",
    platforms: [
        .iOS("17.0")
    ],
    products: [
        .iOSApplication(
            name: "Intesa Sanpaolo",
            targets: ["AppModule"],
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .asset("AppIcon"),
            accentColor: .presetColor(.blue),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: ".",
            resources: [
                .copy("Resources/IntesaSanpaolologologotype.png"),
                .copy("Resources/logoverdeISP.png"),
                .copy("Resources/cartadebitoISP.png"),
                .process("Resources/Assets.xcassets")
            ]
        )
    ]
)
