//
//  AppCoordinator.swift
//  MdEdit
//
//  Created by ioskendev on 12.01.2024.
//

import UIKit
import TaskManagerPackage

final class AppCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private var window: UIWindow?

	private let taskManager: ITaskManager

	// MARK: - Initialization

	init(window: UIWindow?, taskManager: ITaskManager) {
		self.window = window
		self.taskManager = taskManager
		self.navigationController = UINavigationController()
	}

	// MARK: - Internal methods

	override func start() {
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()

		runLoginFlow()
	}

	func runLoginFlow() {
		let coordinator = LoginCoordinator(navigationController: navigationController)
		addDependency(coordinator)

		coordinator.finishFlow = { [weak self, weak coordinator] in
			guard let self = self else { return }
			runStartFlow()
			coordinator.map { self.removeDependency($0) }
		}

		coordinator.start()
	}

	func runMainFlow() {
		let coordinator: ICoordinator = MainCoordinator(
			navigationController: navigationController,
			taskManager: taskManager
		)

		addDependency(coordinator)

		coordinator.start()
	}

	func runStartFlow() {
		let coordinator = StartCoordinator(navigationController: navigationController)
		addDependency(coordinator)
		coordinator.start()
	}
}

extension AppCoordinator: ITestCoordinator {
	func testStart(parameters: [LaunchArguments: Bool]) {
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()

		if let skipLogin = parameters[LaunchArguments.skipLogin], skipLogin {
			runMainFlow()
		} else {
			runLoginFlow()
		}
	}
}
