import ProjectDescription

enum ProjectSettings {
	public static var organizationName: String { "ru.ioskendev.MdEditor" }
	public static var projectName: String { "MdEditor" }
	public static var appVersionName: String { "1.0.0" }
	public static var appVersionBuild: Int { 1 }
	public static var developmentTeam: String { "" }
	public static var targetVersion: String { "15.0" }
	public static var bundleId: String { "\(organizationName).\(projectName)" }
}

private var swiftlintScript: TargetScript {
	let swiftLintScriptString = """
		export PATH="$PATH:/opt/homebrew/bin"
		if which swiftlint > /dev/null; then
			"SwiftLint/swiftlint --fix && SwiftLint/swiftlint"
		else
		  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
		  exit 1
		fi
		"""

	return TargetScript.pre(
		script: swiftLintScriptString,
		name: "Run SwiftLint",
		basedOnDependencyAnalysis: false
	)
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

let target = Target(
	name: ProjectSettings.projectName,
	destinations: .iOS, 
	product: .app,
	bundleId: ProjectSettings.bundleId,
	deploymentTargets: .iOS(ProjectSettings.targetVersion),
	infoPlist: .extendingDefault(with: infoPlist),
	sources: ["Sources/**"],
	resources: ["Resources/**"],
	scripts: [swiftlintScript],
	dependencies: [
		.package(product: "TaskManagerPackage")
	]
)

let testTarget = Target(
	name: "\(ProjectSettings.projectName)Tests",
	destinations: .iOS,
	product: .unitTests,
	bundleId: "\(ProjectSettings.bundleId)Tests",
	deploymentTargets: .iOS(ProjectSettings.targetVersion),
	sources: ["MdEditorTests/Sources/**", "Shared/**"],
	dependencies: [
		.target(name: "\(ProjectSettings.projectName)")
	],
	settings: .settings(base: ["GENERATE_INFOPLIST_FILE": "YES"])
)

let uiTestTarget = Target(
	name: "\(ProjectSettings.projectName)UITests",
	destinations: .iOS,
	product: .uiTests,
	bundleId: "\(ProjectSettings.bundleId)UITests",
	deploymentTargets: .iOS(ProjectSettings.targetVersion),
	sources: ["MdEditorUITests/Sources/**", "Shared/**"],
	dependencies: [
		.target(name: "\(ProjectSettings.projectName)")
	],
	settings: .settings(base: ["GENERATE_INFOPLIST_FILE": "YES"])
)

let project = Project(
	name: ProjectSettings.projectName ,
	options: .options(
		defaultKnownRegions: [ "Base", "en", "ru"],
		developmentRegion: "en"
	),
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
	targets: [target, testTarget, uiTestTarget],
	schemes: [
		Scheme(
			name: "\(ProjectSettings.projectName)",
			shared: true,
			buildAction: .buildAction(targets: ["\(ProjectSettings.projectName)"]),
			testAction: .targets(["\(ProjectSettings.projectName)Tests"]),
			runAction: .runAction(executable: "\(ProjectSettings.projectName)")
		),
		Scheme(
			name: "\(ProjectSettings.projectName)Tests",
			shared: true,
			buildAction: .buildAction(targets: ["\(ProjectSettings.projectName)Tests"]),
			testAction: .targets(["\(ProjectSettings.projectName)Tests"]),
			runAction: .runAction (executable: "\(ProjectSettings.projectName)Tests")
		),
		Scheme(
			name: "\(ProjectSettings.projectName)UITests",
			shared: true,
			buildAction: .buildAction (targets: ["\(ProjectSettings.projectName)UITests"]),
			testAction: .targets(["\(ProjectSettings.projectName)UITests"]),
			runAction: .runAction(executable: "\(ProjectSettings.projectName)UITests")
		)
	]
)
