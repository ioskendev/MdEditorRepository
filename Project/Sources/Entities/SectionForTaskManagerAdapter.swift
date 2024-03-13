//
//  SectionForTaskManagerAdapter.swift
//  MdEditor
//
//  Created by Alexey Turulin on 11/28/23.
//

import Foundation
import TaskManagerPackage

/// Protocol defining the requirements for adapting  task manager data into sections for display.
protocol ISectionForTaskManagerAdapter {

	/// Retrieves all sections representing grouped tasks.
	/// - Returns: An array of 'Section' representing the sections in the task manager.
	func getSections() -> [Section]

	/// Retrieves a specific section by its index.
	/// - Parameter index: The index of the section to retrieve.
	/// - Returns: The 'Section' at the given index.
	func getSection(forIndex index: Int) -> Section

	/// Retrieves tasks for a specific section.
	/// - Parameter section: The section for which to retrieve tasks.
	/// - Returns: An array of 'Task' belonging to the specified section.
	func getTasksForSection(section: Section) -> [Task]
}

/// An enumeration representing the sections within a task management sustem.
enum Section {

	/// Represents completed tasks.
	case completed

	/// Represents uncompleted tasks.
	case uncompleted

	/// represents all tasks.
	case allTasks

	/// Represents important tasks.
	case important

	/// Represents regular tasks.
	case regular

	/// Provides a localized title for each section.
	var title: String {
		switch self {
		case .completed:
			return L10n.TodoList.Section.completed
		case .uncompleted:
			return L10n.TodoList.Section.uncompleted
		case .allTasks:
			return L10n.TodoList.Section.allTasks
		case .important:
			return L10n.TodoList.Section.important
		case .regular:
			return L10n.TodoList.Section.regular
		}
	}
}

/// Adapts the task manager to work with sections.
final class SectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {
	// MARK: - Dependencies

	private let taskManager: ITaskManager

	// MARK: - Private properties

	private let sections: [Section]

	// MARK: - Initialization

	/// Initializes the adapter with a task manager and optional section configuration.
	/// - Parameters:
	///   - taskManager: The task manager instance to adapt.
	///   - sections: The sections to be displayed, with default sections if none provided.
	init(taskManager: ITaskManager, sections: [Section] = [.uncompleted, .completed]) {
		self.taskManager = taskManager
		self.sections = sections
	}

	// MARK: - Public methods

	/// Retrieves all sections representing grouped tasks.
	/// - Returns: An array of 'Section' representing the sections in the task manager.
	func getSections() -> [Section] {
		sections
	}

	/// Retrieves a specific section by its index.
	/// - Parameter index: The index of the section to retrieve.
	/// - Returns: The 'Section' at the given index.
	func getSection(forIndex index: Int) -> Section {
		let correctedIndex = min(index, sections.count - 1)
		return sections[correctedIndex]
	}

	/// Retrieves tasks for a specific section.
	/// - Parameter section: The section for which to retrieve tasks.
	/// - Returns: An array of 'Task' belonging to the specified section.
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
