//
//  TodoListInteractor.swift
//  MdEdit
//
//  Created by ioskendev on 12.01.2024.
//

import Foundation

/// TodoListInteractor protocol
protocol ITodoListInteractor {

	/// Event to response with data to tasklist.
	func fetchData()

	/// Did task selected event method.
	/// - Parameter request: Request, with selected task information.
	func didTaskSelected(request: TodoListModel.Request.TaskSelected)
}

/// Todo List Interactor logic
final class TodoListInteractor: ITodoListInteractor {

	// MARK: - Dependencies

	private var presenter: ITodoListPresenter
	private var sectionManager: ISectionForTaskManagerAdapter

	// MARK: - Initialization

	init(presenter: ITodoListPresenter, sectionManager: ISectionForTaskManagerAdapter) {
		self.presenter = presenter
		self.sectionManager = sectionManager
	}

	// MARK: - Public methods

	/// fetch data realization func.
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

	/// didTaskSelected action realization
	/// - Parameter request: TodoListModel.Request.TaskSelected
	func didTaskSelected(request: TodoListModel.Request.TaskSelected) {
		let section = sectionManager.getSection(forIndex: request.indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[request.indexPath.row]
		task.completed.toggle()
		fetchData()
	}
}
