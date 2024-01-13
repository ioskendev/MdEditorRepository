import ProjectDescription

enum ProjectSettings {
	public static var organizationName: String { "ru.ioskendev.MdEditor" }
	public static var projectName: String { "MdEdit" }
	public static var appVersionName: String { "1.0.0" }
	public static var appVersionBuild: Int { 1 }
	public static var developmentTeam: String { "" }
	public static var targetVersion: String { "15.0" }
	public static var bundleId: String { "\(organizationName).\(projectName)" }
}

public var scripts: [TargetScript] {

	var scripts = [TargetScript]()

	let swiftLintScriptString = """
	 export PATH="$PATH:/opt/homebrew/bin"
	 if which swiftlint > /dev/null; then
	   swiftlint
	 else
	   echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
	   exit 1
	 fi
	 """

	let swiftLintScript = TargetScript.post(
		script: swiftLintScriptString, name: "SwiftLint", basedOnDependencyAnalysis: false
	)

	scripts.append(swiftLintScript)
	return scripts
}

let infoPlist: [String: Plist.Value] = [
	"UIApplicationSceneManifest": [
		"UIApplicationSupportsMultipleScenes": false,
		"UISceneConfigurations": [
			"UIWindowSceneSessionRoleApplication": [
				[
					"UISceneConfigurationName": "Default Configuration",
					"UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
				]
			]
		]
	],
	"UILaunchStoryboardName": "LaunchScreen"
]

let project = Project(
	name: ProjectSettings.projectName ,
	packages: [
		.local(path: .relativeToManifest("../Packages/TaskManagerPackage"))
	],
	settings: .settings(
		base: [
			"DEVELOPMENT_TEAM": "\(ProjectSettings.developmentTeam)",
			"MARKETING_VERSION":"\(ProjectSettings.appVersionName)",
			"CURRENT_PROJECT_VERSION": "\(ProjectSettings.appVersionBuild)",
			"DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym"
		],
		defaultSettings: .recommended()
	),
	targets: [
		Target(
			name: ProjectSettings.projectName,
			destinations: .iOS,
			product: .app,
			bundleId: ProjectSettings.bundleId,
			deploymentTargets: .iOS(ProjectSettings.targetVersion),
			infoPlist: .extendingDefault(with: infoPlist),
			sources: ["Sources/**"],
			resources: [
				"Resources/**",
				"Resources/LaunchScreen.storyboard"
			],
			scripts: scripts,
			dependencies: [
				.package(product: "TaskManagerPackage")
			]
		),
		Target(
			name: "\(ProjectSettings.projectName)Tests",
			destinations: .iOS,
			product: .unitTests,
			bundleId: "\(ProjectSettings.bundleId)Tests",
			deploymentTargets: .iOS(ProjectSettings.targetVersion),
			sources: ["Tests/**"],
			dependencies: [
				.target(name: "\(ProjectSettings.projectName)")
			],
			settings: .settings(base: ["GENERATE_INFOPLIST_FILE": "YES"])
		)
	]
)