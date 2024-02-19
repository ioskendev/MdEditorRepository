//
//  SceneDelegate.swift
//  MdEditor
//
//  Created by ioskendev on 25.12.2023.
//

import UIKit
import TaskManagerPackage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	private var appCoordinator: AppCoordinator! // swiftlint:disable:this implicitly_unwrapped_optional
	private var repository = TaskRepositoryStub()
	private var taskManager: ITaskManager! // swiftlint:disable:this implicitly_unwrapped_optional
	private var fileExplorer: IFileExplorer! // swiftlint:disable:this implicitly_unwrapped_optional
	private var recentFileManager: IRecentFileManager! // swiftlint:disable:this implicitly_unwrapped_optional

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)
		window.makeKeyAndVisible()

		let navigationController = UINavigationController()
		taskManager = OrderedTaskManager(taskManager: TaskManager())
		taskManager.addTasks(tasks: repository.getTasks())
		fileExplorer = FileExplorer()
		recentFileManager = StubRecentFileManager()

		appCoordinator = AppCoordinator(
			router: navigationController,
			taskManager: taskManager,
			fileExplorer: fileExplorer,
			recentFileManager: recentFileManager
		)

		window.rootViewController = navigationController
		self.window = window

		appCoordinator.start()
	}
}
