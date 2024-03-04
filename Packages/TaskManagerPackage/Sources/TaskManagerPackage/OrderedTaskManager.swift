//
//  OrderedTaskManager.swift
//  TaskManagerPackage
//
//  Created by Alexey Turulin on 11/22/23.
//

import Foundation

/// Provides a list of tasks sorted by priority.
public final class OrderedTaskManager: ITaskManager {

	private let taskManager: ITaskManager

	/// Initializes a list of tasks sorted by priority.
	/// - Parameter taskManager: The task manager that will provide the tasks.
	public init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	/// Returns a list of all tasks, sorted by priority.
	///
	/// Complexity: O(n log n), where n is the number of tasks.
	/// - Returns: An array of tasks.
	public func allTasks() -> [Task] {
		sorted(tasks: taskManager.allTasks())
	}

	/// Returns a list of completed tasks, sorted by priority.
	///
	/// Complexity: O(n log n), where n is the number of tasks.
	/// - Returns: An array of tasks.
	public func completedTasks() -> [Task] {
		sorted(tasks: taskManager.completedTasks())
	}

	/// Returns a list of tasks to be completed, sorted by priority.
	///
	/// Complexity: O(n log n), where n is the number of tasks.
	/// - Returns: An array of tasks.
	public func uncompletedTasks() -> [Task] {
		sorted(tasks: taskManager.uncompletedTasks())
	}

	/// Adds a new task.
	///
	/// Complexity: O(1) on average for many calls to append(_:) on an array.
	/// - Parameter task: The task to be added.
	public func addTask(task: Task) {
		taskManager.addTask(task: task)
	}

	/// Adds a list of tasks.
	///
	/// Complexity: O(m) on average, where m is the size of the list being added, 
	/// for many calls to append(_:) on an array.
	/// - Parameter tasks: An array of tasks to be added.
	public func addTasks(tasks: [Task]) {
		taskManager.addTasks(tasks: tasks)
	}

	/// Removes a task from the list. When this method is called, 
	/// all instances of this task will be removed by task identity.
	///
	/// Complexity: O(n), where n is the number of tasks.
	/// - Parameter task: The task to be removed.
	public func removeTask(task: Task) {
		taskManager.removeTask(task: task)
	}
}

private extension OrderedTaskManager {
	func sorted(tasks: [Task]) -> [Task] {
		tasks.sorted {
			if let task0 = $0 as? ImportantTask, let task1 = $1 as? ImportantTask {
				return task0.taskPriority.rawValue > task1.taskPriority.rawValue
			}
			if $0 is ImportantTask, $1 is RegularTask {
				return true
			}
			return false
		}
	}
}
