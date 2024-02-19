//
//  TodoListCoordinator.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/18/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit
import TaskManagerPackage

final class TodoListCoordinator: ICoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController

	// MARK: - Initialization

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Internal methods

	func start() {
		showTodoListScene()
	}

	private func showTodoListScene() {
		let taskManager: ITaskManager = TaskManager()
		let taskRepository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasks(tasks: taskRepository.getTasks())

		let assembler = TodoListAssembler(taskManager: OrderedTaskManager(taskManager: taskManager))
		let viewController = assembler.assembly(createTaskClosure: nil)

		navigationController.setViewControllers([viewController], animated: true)
	}
}
