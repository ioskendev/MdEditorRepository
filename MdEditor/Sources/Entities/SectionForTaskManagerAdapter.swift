//
//  SectionForTaskManagerAdapter.swift
//  MdEdit
//
//  Created by Yuri Volegov on 12.01.2024.
//

import Foundation
import TaskManagerPackage

/// Протокол адаптера, позволяющего использовать TaskManager для предоставления заданий по секциям.
protocol ISectionForTaskManagerAdapter {

	/// Получить список секций.
	/// - Returns: Массив с ссекциями.
	func getSections() -> [Section]

	/// Доступ к секции по индексу.
	/// - Parameter index: Индекс, для которого нужно вернуть секцию.
	/// - Returns: Нужная секция.
	func getSection(forIndex index: Int) -> Section

	/// Получить список заданий для конкретной секции.
	/// - Parameter section: Секция для которой нужен список заданий.
	/// - Returns: Массив с секциями.
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

	func getSection(forIndex index: Int) -> Section {
		let correctedIndex = min(index, sections.count - 1)
		return sections[correctedIndex]
	}

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
