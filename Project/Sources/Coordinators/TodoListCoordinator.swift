//
//  TodoListCoordinator.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/18/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit
import TaskManagerPackage
import MarkdownPackage

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

		if case .success(let file) = File.parse(url: Endpoints.documentTest) {
			let markdownText = String(data: file.contentOfFile() ?? Data(), encoding: .utf8) ?? ""
			let document = MarkdownToDocument().convert(markdownText: markdownText)
			let taskRepository: ITaskRepository = TaskScanner(document: document)

			taskManager.addTasks(tasks: taskRepository.getTasks())

			let assembler = TodoListAssembler(taskManager: OrderedTaskManager(taskManager: taskManager))
			let viewController = assembler.assembly(createTaskClosure: nil)

			navigationController.setViewControllers([viewController], animated: true)
		}
	}
}
