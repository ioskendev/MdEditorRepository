//
//  TaskRepository.swift
//  MdEditor
//
//  Created by Alexey Turulin on 11/28/23.
//

import Foundation
import TaskManagerPackage

/// Репозиторий для получения заданий.
protocol ITaskRepository {

	/// Получить список заданий.
	/// - Returns: Массив заданий.
	func getTasks() -> [Task]
}

/// Stub Репозиторя для получения заданий.
final class TaskRepositoryStub: ITaskRepository {

	/// Возвращает предустановленные данные для приолжения.
	/// - Returns: Массив заданий.
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
