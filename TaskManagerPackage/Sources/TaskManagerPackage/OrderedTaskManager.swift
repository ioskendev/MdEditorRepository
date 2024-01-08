//
//  OrderedTaskManager.swift
//  TaskManagerPackage
//
//  Created by ioskendev on 27.12.2023.
//

import Foundation

/// Prevent ordered task list by priority.
public final class OrderedTaskManager: ITaskManager {

	private let taskManager: ITaskManager


	/// Ordered taskmanager creation.
	/// - Parameter taskManager: Task list manager to give manage point of tasks list with ordering.
	public init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	/// All tasks list.
	///
	/// - Complexity: O(n log n), where n -- task list size.
	/// - Returns: Array of tasks.
	public func allTasks() -> [Task] {
		sorted(tasks: taskManager.allTasks())
	}

	/// Compleated tasks.
	///
	/// - Complexity: O(n log n), where n -- size of task list.
	/// - Returns: Array of tasks.
	public func completedTasks() -> [Task] {
		sorted(tasks: taskManager.completedTasks())
	}

	/// Uncompleated tasks.
	///
	/// - Complexity: O(n log n), где n -- размер списка заданий.
	/// - Returns: Массив заданий.
	public func uncompletedTasks() -> [Task] {
		sorted(tasks: taskManager.uncompletedTasks())
	}

	/// Add new task.
	///
	/// - Complexity: O(1).
	/// - Parameter task: task to adding.
	public func addTask(task: Task) {
		taskManager.addTask(task: task)
	}

	/// Add task list.
	///
	/// - Complexity: O(m), where m is size of "tasks" parameter.
	/// - Parameter tasks: Task list array.
	public func addTasks(tasks: [Task]) {
		taskManager.addTasks(tasks: tasks)
	}

	/// Delete task from list. Delete all tasks by identical method with input Task parameter (x === y).
	///
	/// - Complexity: O(n), where n -- is task list size.
	/// - Parameter task: Task, to deletion.
	public func removeTask(task: Task) {
		taskManager.removeTask(task: task)
	}
}

// Private extension with sorting method
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

