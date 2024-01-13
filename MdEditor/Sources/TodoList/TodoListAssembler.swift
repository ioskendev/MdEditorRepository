//
//  TodoListAssembler.swift
//  MdEdit
//
//  Created by ioskendev on 12.01.2024.
//

import UIKit
import TaskManagerPackage

final class TodoListAssembler {

	// MARK: - Dependencies

	private let taskManager: ITaskManager

	// MARK: - Initialization

	/// Init of TodoListAssembler.
	/// - Parameters:
	///   - taskManager: Task manager.
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	// MARK: - Public methods

	/// Assemble TodoList scene
	/// - Parameter handleCreateTask: delegation of creation task
	/// - Returns: TodoListViewController
	func assembly(createTaskClosure: EmptyClosure?) -> TodoListViewController {
		let viewController = TodoListViewController()
		let sectionForTaskManagerAdapter = SectionForTaskManagerAdapter(taskManager: taskManager)
		let presenter = TodoListPresenter(viewController: viewController, createTaskClosure: createTaskClosure)
		let interactor = TodoListInteractor(presenter: presenter, sectionManager: sectionForTaskManagerAdapter)
		viewController.interactor = interactor

		return viewController
	}
}
