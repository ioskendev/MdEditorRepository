//
//  FinderInteractor.swift
//  MdEdit
//
//  Created by ioskendev on 12.01.2024.
//

import Foundation

/// FinderInteractor protocol
protocol IFinderInteractor {

	/// Event to response with data to tasklist.
	func fetchData()

	/// Did task selected event method.
	/// - Parameter request: Request, with selected task information.
	func didTaskSelected(request: FinderModel.Request.TaskSelected)
}

/// Todo List Interactor logic
final class FinderInteractor: IFinderInteractor {

	// MARK: - Dependencies

	private var presenter: IFinderPresenter
	private var sectionManager: ISectionForTaskManagerAdapter

	// MARK: - Initialization

	init(presenter: IFinderPresenter, sectionManager: ISectionForTaskManagerAdapter) {
		self.presenter = presenter
		self.sectionManager = sectionManager
	}

	// MARK: - Public methods

	/// fetch data realization func.
	func fetchData() {
		var responseData = [FinderModel.Response.SectionWithTasks]()

		for section in sectionManager.getSections() {
			let sectionWithTasks = FinderModel.Response.SectionWithTasks(
				section: section,
				tasks: sectionManager.getTasksForSection(section: section)
			)
			responseData.append(sectionWithTasks)
		}

		let response = FinderModel.Response(data: responseData)
		presenter.present(response: response)
	}

	/// didTaskSelected action realization
	/// - Parameter request: FinderModel.Request.TaskSelected
	func didTaskSelected(request: FinderModel.Request.TaskSelected) {
		let section = sectionManager.getSection(forIndex: request.indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[request.indexPath.row]
		task.completed.toggle()
		fetchData()
	}
}
