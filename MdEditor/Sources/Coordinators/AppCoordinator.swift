//
//  AppCoordinator.swift
//  MdEdit
//
//  Created by Yuri Volegov on 12.01.2024.
//

import UIKit
import TaskManagerPackage

final class AppCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private var window: UIWindow?

	private let taskManager = TaskManager()

	// MARK: - Initialization

	init(window: UIWindow?) {
		self.window = window
		self.navigationController = UINavigationController()
	}

	// MARK: - Internal methods

	override func start() {
		runLoginFlow()
	}

	func runLoginFlow() {
		let coordinator = LoginCoordinator(navigationController: navigationController)
		addDependency(coordinator)

		coordinator.finishFlow = { [weak self, weak coordinator] in
			self?.runMainFlow()
			coordinator.map { self?.removeDependency($0) }
		}

		coordinator.start()

		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}

	func runMainFlow() {
		let coordinator: ICoordinator = TodoListCoordinator(
			navigationController: navigationController,
			taskManager: taskManager
		)

		addDependency(coordinator)

		coordinator.start()

		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}
}
