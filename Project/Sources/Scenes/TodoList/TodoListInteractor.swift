//
//  TodoListInteractor.swift
//  MdEditor
//
//  Created by Alexey Turulin on 11/28/23.
//

import Foundation

protocol ITodoListInteractor {

	/// Событие на предоставление информации для списка заданий.
	func fetchData()

	/// Событие, что задание было выбрано.
	/// - Parameter request: Запрос, содержащий информацию о выбранном задании.
	func didTaskSelected(request: TodoListModel.Request.TaskSelected)

	func createTask()
}

final class TodoListInteractor: ITodoListInteractor {

	// MARK: - Dependencies

	private let presenter: ITodoListPresenter
	private let sectionManager: ISectionForTaskManagerAdapter
	private var createTaskClosure: (() -> Void)?

	// MARK: - Initialization

	init(
		presenter: ITodoListPresenter,
		sectionManager: ISectionForTaskManagerAdapter,
		createTaskClosure: (() -> Void)?
	) {
		self.presenter = presenter
		self.sectionManager = sectionManager
		self.createTaskClosure = createTaskClosure
	}

	// MARK: - Public methods

	/// Событие на предоставление информации для списка заданий.
	func fetchData() {
		var responseData = [TodoListModel.Response.SectionWithTasks]()

		for section in sectionManager.getSections() {
			let sectionWithTasks = TodoListModel.Response.SectionWithTasks(
				section: section,
				tasks: sectionManager.getTasksForSection(section: section)
			)
			responseData.append(sectionWithTasks)
		}

		let response = TodoListModel.Response(data: responseData)
		presenter.present(response: response)
	}

	/// Событие, что задание было выбрано.
	/// - Parameter request: Запрос, содержащий информацию о выбранном задании.
	func didTaskSelected(request: TodoListModel.Request.TaskSelected) {
		let section = sectionManager.getSection(forIndex: request.indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[request.indexPath.row]
		task.completed.toggle()
		fetchData()
	}

	func createTask() {
		createTaskClosure?()
	}
}
