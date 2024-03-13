//
//  TaskRepository.swift
//  MdEditor
//
//  Created by Alexey Turulin on 11/28/23.
//

import Foundation
import TaskManagerPackage

/// Protocol defining the operations for accessing tasks from a repository.
protocol ITaskRepository {

	/// Retrieves all tasks from the repository.
	/// - Returns: An array of 'Task' objects representing all the tasks stored in the repository.
	func getTasks() -> [Task]
}

/// A stub implementation of 'ITaskRepository' for testing or development purposes.
final class TaskRepositoryStub: ITaskRepository {

	/// Provides a static list of tasks.
	/// - Returns: An array of 'Task' instances to simulate a set of tasks.
	func getTasks() -> [Task] {
		[
			ImportantTask(title: L10n.Task.doHomework, taskPriority: .high),
			RegularTask(title: L10n.Task.doWorkout, completed: true),
			ImportantTask(title: L10n.Task.writeNewTasks, taskPriority: .low),
			RegularTask(title: L10n.Task.solve3Algorithms),
			ImportantTask(title: L10n.Task.goShopping, taskPriority: .medium)
		]
	}
}
