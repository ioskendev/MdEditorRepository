//
//  TodoListCoordinator.swift
//  MdEdit
//
//  Created by ioskendev on 12.01.2024.
//

import UIKit
import TaskManagerPackage

final class TodoListCoordinator: ICoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private let taskManager: TaskManager

	// MARK: - Initialization

	init(navigationController: UINavigationController, taskManager: TaskManager) {
		self.navigationController = navigationController
		self.taskManager = taskManager
	}

	// MARK: - Internal methods

	func start() {
		showTodoListScene()
	}

	private func showTodoListScene() {
		let repository = TaskRepositoryStub()
		let orderedTaskManager = OrderedTaskManager(taskManager: taskManager)
		orderedTaskManager.addTasks(tasks: repository.getTasks())

		let assembler = TodoListAssembler(taskManager: orderedTaskManager)
		let viewController = assembler.assembly {
			//			self.showCreateTaskScene()
		}
		navigationController.pushViewController(viewController, animated: true)
	}
}
