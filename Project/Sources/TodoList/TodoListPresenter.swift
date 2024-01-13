//
//  TodoListPresenter.swift
//  MdEdit
//
//  Created by ioskendev on 12.01.2024.
//

import Foundation
import TaskManagerPackage

/// ITodoList Presentation logic protocol
protocol ITodoListPresenter {

	/// Show screen with task list.
	/// - Parameter response: Prepared data to show.
	func present(response: TodoListModel.Response)

	/// ITodoList Presentation logic
	func createTask()
}

typealias EmptyClosure = () -> Void

final class TodoListPresenter: ITodoListPresenter {

	// MARK: - Dependencies

	private weak var viewController: ITodoListViewController! // swiftlint:disable:this implicitly_unwrapped_optional
	private var createTaskClosure: EmptyClosure?

	// MARK: - Initialization

	init(viewController: ITodoListViewController, createTaskClosure: EmptyClosure?) {
		self.viewController = viewController
		self.createTaskClosure = createTaskClosure
	}

	// MARK: - Public methods

	func present(response: TodoListModel.Response) {
		var sections = [TodoListModel.ViewModel.Section]()
		for sectionWithTask in response.data {
			let sectionData = TodoListModel.ViewModel.Section(
				title: sectionWithTask.section.title,
				tasks: mapTasksData(tasks: sectionWithTask.tasks)
			)
			sections.append(sectionData)
		}
		viewController.render(viewModel: TodoListModel.ViewModel(tasksBySections: sections))
	}

	func createTask() {
		createTaskClosure?()
	}

	// MARK: - Private methods

	private func mapTasksData(tasks: [Task]) -> [TodoListModel.ViewModel.Task] {
		tasks.map { mapTaskData(task: $0) }
	}

	/// Map task from business model to task to show
	/// - Parameter task: Task to mapping.
	/// - Returns: Mapping result.
	private func mapTaskData(task: Task) -> TodoListModel.ViewModel.Task {
		if let task = task as? ImportantTask {
			let result = TodoListModel.ViewModel.ImportantTask(
				title: task.title,
				completed: task.completed,
				deadLine: "Deadline: \(task.deadLine)",
				priority: "\(task.taskPriority)"
			)
			return .importantTask(result)
		} else {
			return .regularTask(
				TodoListModel.ViewModel.RegularTask(
					title: task.title,
					completed: task.completed
				)
			)
		}
	}
}
