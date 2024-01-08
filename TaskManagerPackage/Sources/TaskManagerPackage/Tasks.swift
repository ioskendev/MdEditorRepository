//
//  Tasks.swift
//  TaskManagerPackage
//
//  Created by ioskendev on 27.12.2023.
//

import Foundation

/// Task to tasklist.
public class Task {

	/// Task title.
	public var title: String

	/// Task status: completead or not (bool).
	public var completed = false

	public init(title: String, completed: Bool = false) {
		self.title = title
		self.completed = completed
	}
}

/// Simple task for tasklist.
public final class RegularTask: Task { }

/// ImportantTask for tasklist.
public final class ImportantTask: Task {

	/// Task priority. Priority is manage of task deadline.
	public enum TaskPriority: Int {
		/// Low priority. 3 days.
		case low
		/// Medium priority. 2 days.
		case medium
		/// High priority. 1 day.
		case high
	}

	/// Task deadline.
	public var deadLine: Date {
		switch taskPriority {
		case .low:
			return Calendar.current.date(byAdding: .day, value: 3, to: createDate)!
		case .medium:
			return Calendar.current.date(byAdding: .day, value: 2, to: createDate)!
		case .high:
			return Calendar.current.date(byAdding: .day, value: 1, to: createDate)!
		}
	}

	/// Task creation date.
	private let createDate: Date

	/// Task priority.
	public var taskPriority: TaskPriority

	public init(title: String, taskPriority: TaskPriority, createDate: Date = Date()) {
		self.taskPriority = taskPriority
		self.createDate = createDate
		super.init(title: title)
	}
}
