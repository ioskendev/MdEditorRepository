//
//  TodoListInteractor.swift
//  MdEdit
//
//  Created by Yuri Volegov on 12.01.2024.
//

import Foundation

protocol ITodoListInteractor {

	/// Событие на предоставление информации для списка заданий.
	func fetchData()

	/// Событие, что задание было выбрано.
	/// - Parameter request: Запрос, содержащий информацию о выбранном задании.
	func didTaskSelected(request: TodoListModel.Request.TaskSelected)

	/// Событие на создание нового задания.
	func createTask()
}

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

	/// Событие на создание нового задания.
	func createTask() {
		presenter.createTask()
	}
}
