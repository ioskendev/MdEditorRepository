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
			ImportantTask(title: "Do homework", taskPriority: .high),
			RegularTask(title: "Do Workout", completed: true),
			ImportantTask(title: "Write new tasks", taskPriority: .low),
			RegularTask(title: "Solve 3 algorithms"),
			ImportantTask(title: "Go shopping", taskPriority: .medium)
		]
	}
}
