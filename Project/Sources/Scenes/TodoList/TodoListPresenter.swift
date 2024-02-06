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
}

final class TodoListPresenter: ITodoListPresenter {

	// MARK: - Dependencies

	private weak var viewController: ITodoListViewController! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: - Initialization

	init(viewController: ITodoListViewController) {
		self.viewController = viewController
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
				deadLine: L10n.TodoList.deadline(formatDate(task.deadLine)),
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

	private func formatDate(_ date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = L10n.TodoList.dateFormat
		return formatter.string(from: date)
	}
}

extension ImportantTask.TaskPriority: CustomStringConvertible {
	public var description: String {
		switch self {
		case .high:
			return L10n.TodoList.TaskPriority.high
		case .medium:
			return L10n.TodoList.TaskPriority.medium
		case .low:
			return L10n.TodoList.TaskPriority.low
		}
	}
}
