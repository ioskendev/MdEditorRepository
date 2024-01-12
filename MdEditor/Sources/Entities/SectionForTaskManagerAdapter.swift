//
//  SectionForTaskManagerAdapter.swift
//  MdEdit
//
//  Created by Yuri Volegov on 12.01.2024.
//

import Foundation
import TaskManagerPackage

/// Adapter protocol, to use TaskManager to return tasks from sections.
protocol ISectionForTaskManagerAdapter {

	/// Get list of sections.
	/// - Returns: Array with sections.
	func getSections() -> [Section]

	/// Access to section from index.
	/// - Parameter index: Index, to return section with.
	/// - Returns: Section.
	func getSection(forIndex index: Int) -> Section

	/// Get tasks for section.
	/// - Parameter section: Section to return tasks.
	/// - Returns: Array with Tasks.
	func getTasksForSection(section: Section) -> [Task]
}

enum Section {
	case completed
	case uncompleted
	case allTasks
	case important
	case regular

	var title: String {
		switch self {
		case .completed:
			return "Completed"
		case .uncompleted:
			return "Uncompleted"
		case .allTasks:
			return "All"
		case .important:
			return "Important"
		case .regular:
			return "Regular"
		}
	}
}

/// SectionForTaskManagerAdapter provide new functions with sections to ITaskManager type member
final class SectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {
	// MARK: - Dependencies

	private let taskManager: ITaskManager

	// MARK: - Private properties

	private let sections: [Section]

	// MARK: - Initialization

	init(taskManager: ITaskManager, sections: [Section] = [.uncompleted, .completed]) {
		self.taskManager = taskManager
		self.sections = sections
	}

	// MARK: - Public methods

	func getSections() -> [Section] {
		sections
	}

	/// Get section for index
	/// - Parameter index: index of section
	/// - Returns: Section for index
	func getSection(forIndex index: Int) -> Section {
		let correctedIndex = min(index, sections.count - 1)
		return sections[correctedIndex]
	}

	/// return array of TaskManagerPackage Tasks from tasks type
	/// - Parameter section: enum Section with staks description
	/// - Returns: [TaskManagerPackage.Task]
	func getTasksForSection(section: Section) -> [TaskManagerPackage.Task] {
		switch section {
		case .completed:
			return taskManager.completedTasks()
		case .uncompleted:
			return taskManager.uncompletedTasks()
		case .allTasks:
			return taskManager.allTasks()
		case .important:
			return taskManager.allTasks().filter { $0 is ImportantTask }
		case .regular:
			return taskManager.allTasks().filter { $0 is RegularTask }
		}
	}
}
