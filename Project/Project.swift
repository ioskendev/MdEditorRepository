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

	let swiftGenScriptString = """
	 export PATH="$PATH:/opt/homebrew/bin"
	 OUTPUT_FILES=()
	 COUNTER=0
	 while [ $COUNTER -lt ${SCRIPT_OUTPUT_FILE_COUNT} ];
	 do
	  tmp="SCRIPT_OUTPUT_FILE_$COUNTER"
	  OUTPUT_FILES+=("${!tmp}")
	  COUNTER=$[$COUNTER+1]
	 done
	 for file in "${OUTPUT_FILES[@]}"
	 do
	  if [ -f "$file" ]
	  then
	   chmod a=rw "$file"
	  fi
	 done

	 if which swiftgen > /dev/null; then
	  swiftgen config run --config swiftgen.yml
	 else
	  echo "warning: SwiftGen not installed, download from https://github.com/SwiftGen/SwiftGen"
	  exit 1
	 fi

	 for file in "${OUTPUT_FILES[@]}"
	 do
	  chmod a=r "$file"
	 done
	"""

	let swiftLintScript = TargetScript.post(
		script: swiftLintScriptString, name: "SwiftLint", basedOnDependencyAnalysis: false
	)

	let swiftGenScript = TargetScript.post(
		script: swiftGenScriptString,
		name: "SwiftGen",
		basedOnDependencyAnalysis: false
	)

	scripts.append(swiftLintScript)
	scripts.append(swiftGenScript)
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
				"Resources/LaunchScreen.storyboard",
				"Resources/en.lproj/Localizable.strings",
				"Resources/ru.lproj/Localizable.strings"
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
