//
//  FinderPresenter.swift
//  MdEdit
//
//  Created by ioskendev on 12.01.2024.
//

import Foundation
import TaskManagerPackage

/// IFinder Presentation logic protocol
protocol IFinderPresenter {

	/// Show screen with task list.
	/// - Parameter response: Prepared data to show.
	func present(response: FinderModel.Response)
}

final class FinderPresenter: IFinderPresenter {

	// MARK: - Dependencies

	private weak var viewController: IFinderViewController! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: - Initialization

	init(viewController: IFinderViewController) {
		self.viewController = viewController
	}

	// MARK: - Public methods

	func present(response: FinderModel.Response) {
		var sections = [FinderModel.ViewModel.Section]()
		for sectionWithTask in response.data {
			let sectionData = FinderModel.ViewModel.Section(
				title: sectionWithTask.section.title,
				tasks: mapTasksData(tasks: sectionWithTask.tasks)
			)
			sections.append(sectionData)
		}
		viewController.render(viewModel: FinderModel.ViewModel(tasksBySections: sections))
	}

	// MARK: - Private methods

	private func mapTasksData(tasks: [Task]) -> [FinderModel.ViewModel.Task] {
		tasks.map { mapTaskData(task: $0) }
	}

	/// Map task from business model to task to show
	/// - Parameter task: Task to mapping.
	/// - Returns: Mapping result.
	private func mapTaskData(task: Task) -> FinderModel.ViewModel.Task {
		if let task = task as? ImportantTask {
			let result = FinderModel.ViewModel.ImportantTask(
				title: task.title,
				completed: task.completed,
				deadLine: L10n.Finder.deadline(formatDate(task.deadLine)),
				priority: "\(task.taskPriority)"
			)
			return .importantTask(result)
		} else {
			return .regularTask(
				FinderModel.ViewModel.RegularTask(
					title: task.title,
					completed: task.completed
				)
			)
		}
	}

	private func formatDate(_ date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = L10n.Finder.dateFormat
		return formatter.string(from: date)
	}
}
