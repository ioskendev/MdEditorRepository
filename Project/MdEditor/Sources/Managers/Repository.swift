//
//  TaskRepository.swift
//  MdEdit
//
//  Created by ioskendev on 12.01.2024.
//

import Foundation
import TaskManagerPackage

/// Repository to get tasks.
protocol ITaskRepository {

	/// Get task list.
	/// - Returns: Array of tasks.
	func getTasks() -> [Task]
}

/// Stub Repository to get tasks.
final class TaskRepositoryStub: ITaskRepository {

	/// Return stub data with tasks.
	/// - Returns: Array of tasks.
	func getTasks() -> [Task] {
		[
			ImportantTask(title: L10n.Task.doHomework, taskPriority: .high),
			RegularTask(title: L10n.Task.doHomework, completed: true),
			ImportantTask(title: L10n.Task.writeNewTasks, taskPriority: .low),
			RegularTask(title: L10n.Task.solve3Algorithms),
			ImportantTask(title: L10n.Task.goShopping, taskPriority: .medium)
		]
	}
}
