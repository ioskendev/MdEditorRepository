//
//  TasksStub.swift
//
//
//  Created by Maxim Alekseev on 06.01.2024.
//

import TaskManagerPackage
import Foundation

/// Отдает заранее подготовленные Tasks
protocol ITasksStub {
	/// Отдает предопределенные Tasks
	/// Returns массив [Task]
	func getTasks() -> [Task]
}

/// Отдает заранее подготовленные Tasks
final class TasksStub: ITasksStub {
	/// Отдает предопределенные Tasks
	/// Returns массив [Task]
	func getTasks() -> [Task] {
		return [
			ImportantTask(title: "Do homework", taskPriority: .high),
			RegularTask(title: "Do Workout", completed: true),
			ImportantTask(title: "Write new tasks", taskPriority: .low, createDate: Date()),
			RegularTask(title: "Solve 3 algorithms"),
			ImportantTask(title: "Go shopping", taskPriority: .medium, createDate: Date())
		]
	}
}
