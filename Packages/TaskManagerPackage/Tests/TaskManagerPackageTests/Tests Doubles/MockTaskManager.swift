//
//  MockTaskManager.swift
//  
//
//  Created by Alexey Turulin on 1/13/24.
//

@testable import TaskManagerPackage

final class MockTaskManager: ITaskManager {

	static let highImportantTask = ImportantTask(title: "highImportantTask", taskPriority: .high)
	static let mediumImportantTask = ImportantTask(title: "mediumImportantTask", taskPriority: .medium)
	static let lowImportantTask = ImportantTask(title: "lowImportantTask", taskPriority: .low)
	static let completedRegularTask = RegularTask(title: "completedRegularTask", completed: true)
	static let uncompletedRegularTask = RegularTask(title: "uncopletedRegularTask")

	func allTasks() -> [TaskManagerPackage.Task] {
		[
			MockTaskManager.highImportantTask,
			MockTaskManager.lowImportantTask,
			MockTaskManager.completedRegularTask,
			MockTaskManager.mediumImportantTask,
			MockTaskManager.uncompletedRegularTask
		]
	}

	func completedTasks() -> [TaskManagerPackage.Task] {
		[MockTaskManager.completedRegularTask]
	}

	func uncompletedTasks() -> [TaskManagerPackage.Task] {
		[
			MockTaskManager.highImportantTask,
			MockTaskManager.lowImportantTask,
			MockTaskManager.mediumImportantTask,
			MockTaskManager.uncompletedRegularTask
		]
	}

	func addTask(task: TaskManagerPackage.Task) {
		fatalError("Not implemented")
	}

	func addTasks(tasks: [TaskManagerPackage.Task]) {
		fatalError("Not implemented")
	}

	func removeTask(task: TaskManagerPackage.Task) {
		fatalError("Not implemented")
	}
}
