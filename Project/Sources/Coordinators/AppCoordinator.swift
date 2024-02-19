//
//  AppCoordinator.swift
//  MdEditor
//
//  Created by Alexey Turulin on 1/14/24.
//

import UIKit
import TaskManagerPackage

final class AppCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private let taskManager: ITaskManager
	private let fileExplorer: IFileExplorer
	private let recentFileManager: IRecentFileManager

	// MARK: - Initialization

	init(
		router: UINavigationController,
		taskManager: ITaskManager,
		fileExplorer: IFileExplorer,
		recentFileManager: IRecentFileManager
	) {
		self.navigationController = router
		self.taskManager = taskManager
		self.fileExplorer = fileExplorer
		self.recentFileManager = recentFileManager
	}

	// MARK: - Internal methods

	override func start() {
#if DEBUG
		let parameters = LaunchArguments.parameters()
		if let enableTesting = parameters[LaunchArguments.enableTesting], enableTesting {
			UIView.setAnimationsEnabled(false)
		}
		if let skipLogin = parameters[LaunchArguments.skipLogin], skipLogin {
			runMainFlow()
		} else {
			runLoginFlow()
		}
#else
		runLoginFlow()
#endif
	}
}

// MARK: - Private methods
private extension AppCoordinator {
	func runLoginFlow() {
		let coordinator = LoginCoordinator(navigationController: navigationController)
		addDependency(coordinator)

		coordinator.finishFlow = { [weak self, weak coordinator] in
			guard let self = self else { return }

#if DEBUG
			let parameters = LaunchArguments.parameters()
			if let enableTesting = parameters[LaunchArguments.enableTesting], enableTesting {
				UIView.setAnimationsEnabled(false)
				self.runTodoListFlow()
			} else {
				self.runMainFlow()
			}
#else
			self.runMainFlow()
#endif

			if let coordinator = coordinator {
				self.removeDependency(coordinator)
			}
		}

		coordinator.start()
	}

	func runMainFlow() {
		let coordinator = MainCoordinator(
			navigationController: navigationController,
			fileExplorer: fileExplorer,
			recentFileManager: recentFileManager
		)
		addDependency(coordinator)
		coordinator.start()
	}

	func runTodoListFlow() {
		let coordinator = TodoListCoordinator(navigationController: navigationController)
		addDependency(coordinator)
		coordinator.start()
	}
}
