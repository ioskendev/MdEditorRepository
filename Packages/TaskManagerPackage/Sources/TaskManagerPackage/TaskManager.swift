//
//  TaskManager.swift
//  TaskManagerPackage
//
//  Created by ioskendev on 27.12.2023.
//

/// Task manager.
public final class TaskManager {
	private var taskList = [Task]()

	/// Task list creation.
	/// - Parameter taskList: Tasks to put into tasklist storage.
	public init(taskList: [Task] = [Task]()) {
		self.taskList = taskList
	}

	/// All tasks link.
	/// - Returns: Array of tasks.
	public func allTasks() -> [Task] {
		taskList
	}

	/// Tasks list.
	/// - Returns: task array.
	public func completedTasks() -> [Task] {
		taskList.filter { $0.completed }
	}

	/// Task list to do.
	/// - Returns: Array of tasks.
	public func uncompletedTasks() -> [Task] {
		taskList.filter { !$0.completed }
	}

	/// Add new task.
	///
	/// - Complexity: O(1) with multiple append(_:) calls in array.
	/// - Parameter task: Task.
	public func addTask(task: Task) {
		taskList.append(task)
	}

	/// Add tasklist.
	///
	/// - Complexity: O(m), where m is taskList size, with multiple append(_:) calls in array.
	/// - Parameter tasks: Task array.
	public func addTasks(tasks: [Task]) {
		taskList.append(contentsOf: tasks)
	}

	/// Delete task from list. When it calls Task deletes with identical object link "x === y".
	///
	/// - Complexity: O(n), where n -- taskList saze.
	/// - Parameter task: Task to delete.
	public func removeTask(task: Task) {
		taskList.removeAll { $0 === task }
	}
}
