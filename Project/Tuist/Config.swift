import ProjectDescription

let config = Config(
	compatibleXcodeVersions: ["15.1"],
	swiftVersion: "5.9.2",
    plugins: [
        .local(path: .relativeToManifest("../../Plugins/MdEditor")),
    ]
)
