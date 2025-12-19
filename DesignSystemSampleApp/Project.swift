import ProjectDescription

let project = Project(
    name: "DesignSystemSampleApp",
    targets: [
        .target(
            name: "DesignSystemSampleApp",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.DesignSystemSampleApp",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            buildableFolders: [
                "DesignSystemSampleApp/Sources",
                "DesignSystemSampleApp/Resources",
            ],
            dependencies: [
              .external(name: "DesignSystem")
            ]
        ),
        .target(
            name: "DesignSystemSampleAppTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.DesignSystemSampleAppTests",
            infoPlist: .default,
            buildableFolders: [
                "DesignSystemSampleApp/Tests"
            ],
            dependencies: [.target(name: "DesignSystemSampleApp")]
        ),
    ]
)
