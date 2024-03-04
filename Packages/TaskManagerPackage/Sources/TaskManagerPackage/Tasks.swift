//
//  Tasks.swift
//  TaskManagerPackage
//
//  Created by Alexey Turulin on 11/22/23.
//

import Foundation

/// Represents a task for managing a todo list.
public class Task {

	/// The name of the task.
	public var title: String

	/// Indicates whether the task is marked as completed.
	public var completed = false

	/// Initializes a new Task instance.
	/// - Parameters:
	///   - title: The title or description of the task.
	///   - completed: A boolean value indicating whether the task is already completed at the time of creation.
	///   Defaults to 'false'.
	public init(title: String, completed: Bool = false) {
		self.title = title
		self.completed = completed
	}
}

/// Represents a regular task for managing todo list.
public final class RegularTask: Task { }

/// Represents an important task with a priority for managing a todo list.
public final class ImportantTask: Task {

	/// The priority of the task.
	public enum TaskPriority: Int {
		/// Low priority. Assigned 3 days to complete.
		case low
		/// Medium priority. Assigned 2 days to complete.
		case medium
		/// High priority. Assigned 1 days to complete.
		case high
	}

	/// The deadline by which the task must be completed.
	public var deadLine: Date {
		switch taskPriority {
		case .low:
			return Calendar.current.date(byAdding: .day, value: 3, to: createDate)! // swiftlint:disable:this force_unwrapping
		case .medium:
			return Calendar.current.date(byAdding: .day, value: 2, to: createDate)! // swiftlint:disable:this force_unwrapping
		case .high:
			return Calendar.current.date(byAdding: .day, value: 1, to: createDate)! // swiftlint:disable:this force_unwrapping
		}
	}

	/// The date the task was created.
	private let createDate: Date

	/// The priority of the task.
	public var taskPriority: TaskPriority

	/// initializes an important task with specified parameters.
	/// - Parameters:
	///   - title: the title of the task.
	///   - taskPriority: The priority of the task.
	///   - createDate: the date when the task was created. Defaults to the current date.
	public init(title: String, taskPriority: TaskPriority, createDate: Date = Date()) {
		self.taskPriority = taskPriority
		self.createDate = createDate
		super.init(title: title)
	}
}

extension Task: Equatable {

	/// Determines if two Task instances are the same.
	/// - Parameters:
	///   - lhs: The left-hand side Task instance for comparison.
	///   - rhs: The right-hand side Task instance for comparison.
	/// - Returns: A Boolean value indicating whether the two instances represent the same Task.
	public static func == (lhs: Task, rhs: Task) -> Bool {
		lhs === rhs
	}
}
