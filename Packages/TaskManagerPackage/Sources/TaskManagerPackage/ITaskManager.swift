//
//  ITaskManager.swift
//  TaskManagerPackage
//
//  Created by Alexey Turulin on 11/22/23.
//

/// The Task Manager Protocol.
public protocol ITaskManager {

	/// Returns all completed tasks.
	/// - Returns: An array of completed 'Task' instances.
	func allTasks() -> [Task]

	/// Returns all complited tasks.
	/// - Returns: An array of complited 'Task' instances.
	func completedTasks() -> [Task]

	/// Returns all uncomplited tasks.
	/// - Returns: An array of uncomplited 'Task' instances.
	func uncompletedTasks() -> [Task]

	/// Add a new task.
	/// - Parameter task: The 'Task' instance to add.
	func addTask(task: Task)

	/// Adds an array of tasks.
	/// - Parameter tasks: An array of 'Task' instances to add.
	func addTasks(tasks: [Task])

	/// Removes a task.
	/// - Parameter task: The 'Task' instance to remove.
	func removeTask(task: Task)
}

extension TaskManager: ITaskManager { }
