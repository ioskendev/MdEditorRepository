//
//  TestAppCoordinator.swift
//  MdEditor
//
//  Created by Alexey Turulin on 3/1/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit

final class TestAppCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController

	// MARK: - Initialization

	init(router: UINavigationController) {
		self.navigationController = router
	}

	// MARK: - Internal methods

	override func start() {
		let parameters = LaunchArguments.parameters()
		if let enableTesting = parameters[LaunchArguments.enableTesting], enableTesting {
			UIView.setAnimationsEnabled(false)
		}

		if let needRunMainFlow = parameters[LaunchArguments.runMainFlow], needRunMainFlow {
			runMainFlow()
		} else if let needRunTodoListFlow = parameters[LaunchArguments.runTodoListFlow], needRunTodoListFlow {
			runTodoListFlow()
		} else {
			runLoginFlow()
		}
	}
}

// MARK: - Private methods

private extension TestAppCoordinator {

	func runLoginFlow() {
		let coordinator = LoginCoordinator(navigationController: navigationController)
		addDependency(coordinator)

		coordinator.finishFlow = { [weak self, weak coordinator] in
			guard let self = self else { return }

			self.runMainFlow()

			if let coordinator = coordinator {
				self.removeDependency(coordinator)
			}
		}

		coordinator.start()
	}

	func runMainFlow() {
		let coordinator = MainCoordinator(navigationController: navigationController)
		addDependency(coordinator)
		coordinator.start()
	}

	func runTodoListFlow() {
		let coordinator = TodoListCoordinator(navigationController: navigationController)
		addDependency(coordinator)
		coordinator.start()
	}
}
