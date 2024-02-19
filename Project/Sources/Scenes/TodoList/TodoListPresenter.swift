//
//  TodoListPresenter.swift
//  MdEditor
//
//  Created by Alexey Turulin on 11/28/23.
//

import Foundation
import TaskManagerPackage

protocol ITodoListPresenter {

	/// Отображение экрана со списком заданий.
	/// - Parameter response: Подготовленные к отображению данные.
	func present(response: TodoListModel.Response)
}

final class TodoListPresenter: ITodoListPresenter {

	// MARK: - Dependencies

	private weak var viewController: ITodoListViewController?

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
		viewController?.render(viewModel: TodoListModel.ViewModel(tasksBySections: sections))
	}

	// MARK: - Private methods

	private func mapTasksData(tasks: [Task]) -> [TodoListModel.ViewModel.Task] {
		tasks.map { mapTaskData(task: $0) }
	}

	/// Мапинг одного задания из бизнес-модели в задание для отображения
	/// - Parameter task: Задание для преобразования.
	/// - Returns: Преобразованный результат.
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
