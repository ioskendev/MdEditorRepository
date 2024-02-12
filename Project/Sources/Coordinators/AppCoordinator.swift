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
	private var window: UIWindow?
	private let taskManager: ITaskManager
	private let fileExplorer: IFileExplorer
	private let converter: IMarkdownToHTMLConverter

	// MARK: - Initialization

	init(window: UIWindow?, taskManager: ITaskManager, fileExplorer: IFileExplorer, converter: IMarkdownToHTMLConverter) {
		self.window = window
		self.taskManager = taskManager
		self.navigationController = UINavigationController()
		self.fileExplorer = fileExplorer
		self.converter = converter
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
			self?.runMainFlow()
			coordinator.map { self?.removeDependency($0) }
		}

		coordinator.start()
	}

	func runMainFlow() {
		let coordinator = MainCoordinator(
			navigationController: navigationController,
			fileExplorer: fileExplorer
		)
		addDependency(coordinator)

		coordinator.finishFlow = { [weak self] nextSCreen in
			switch nextSCreen {
			case .about:
				self?.runAboutFlow()
			case .open:
				self?.runOpenFlow()
			}
		}

		coordinator.start()
	}

	func runAboutFlow() {
		let coordinator = AboutCoordinator(
			navigationController: navigationController,
			fileExplorer: fileExplorer,
			converter: converter
		)
		addDependency(coordinator)

		coordinator.finishFlow = { [weak self, weak coordinator] in
			coordinator.map { self?.removeDependency($0) }
		}

		coordinator.start()
	}

	func runOpenFlow() {
		let coordinator = OpenCoordinator(
			navigationController: navigationController,
			fileExplorer: fileExplorer
		)
		addDependency(coordinator)

		coordinator.finishFlow = { [weak self, weak coordinator] in
			coordinator.map { self?.removeDependency($0) }
		}

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
