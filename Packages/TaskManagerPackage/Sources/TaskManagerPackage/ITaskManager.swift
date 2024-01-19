//
//  ITaskManager.swift
//  TaskManagerPackage
//
//  Created by ioskendev on 27.12.2023.
//

/// TaskManager protocol
public protocol ITaskManager {
	/// All tasks list.
	/// - Returns: Array of task list.
	func allTasks() -> [Task]
	
	/// List of compleated tasks..
	/// - Returns: Массив заданий.
	func completedTasks() -> [Task]

	/// List of uncompleated tasks.
	/// - Returns: Массив заданий.
	func uncompletedTasks() -> [Task]

	/// Add new task.
	/// - Parameter task: Task to add.
	func addTask(task: Task)

	/// Adding task list.
	/// - Parameter tasks: Array of tasks.
	func addTasks(tasks: [Task])

	/// Delete task from list. Delete all tasks with identical obgect link with parameter "task".
	/// - Parameter task: Задание, которое необходимо удалить.
	func removeTask(task: Task)
}

extension TaskManager: ITaskManager { }
