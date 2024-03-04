//
//  TaskManager.swift
//  TaskManagerPackage
//
//  Created by Alexey Turulin on 11/22/23.
//

/// TaskManager class.
public final class TaskManager {
	private var taskList = [Task]()

	/// Initializes a task manager with an optional list of tasks.
	/// - Parameter taskList: An array of 'Task' objects to initialize the task list.
	/// Defaults is an empty arrray.
	public init(taskList: [Task] = [Task]()) {
		self.taskList = taskList
	}

	/// Returns all tasks.
	/// - Returns: An array of all tasks.
	public func allTasks() -> [Task] {
		taskList
	}

	/// Returns all completed tasks.
	/// - Returns: An array of all completed tasks.
	public func completedTasks() -> [Task] {
		taskList.filter { $0.completed }
	}

	/// Returns all uncompleted tasks.
	/// - Returns: An array of all uncompleted tasks.
	public func uncompletedTasks() -> [Task] {
		taskList.filter { !$0.completed }
	}

	/// Adds a new task to the task list.
	///
	/// Complexity: On average O(1) for many calls to the append(_:) method in an array.
	/// - Parameter task: The 'Task' to be added..
	public func addTask(task: Task) {
		taskList.append(task)
	}

	/// Adds an array of tasks to the task list.
	///
	/// “Complexity: On average O(m), where  is the size of the list of tasks being added, 
	/// for many calls to the append(_:) method in an array.”
	/// - Parameter tasks: An array of 'Task' objects to be added.
	public func addTasks(tasks: [Task]) {
		taskList.append(contentsOf: tasks)
	}

	/// Removes a task from the task list.
	///
	/// Complexity: O(n), where n is the size of the list of tasks.
	/// - Parameter task: The 'Task' to be removed.
	public func removeTask(task: Task) {
		taskList.removeAll { $0 === task }
	}
}
