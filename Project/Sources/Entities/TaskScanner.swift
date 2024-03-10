//
//  TaskScanner.swift
//  MdEditor
//
//  Created by Alexey Turulin on 3/1/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation
import MarkdownPackage
import TaskManagerPackage

/// Scans a document structure to identify and extract tasks.
final class TaskScanner: ITaskRepository {

	// MARK: - Dependencies

	private let visitor = AttributedTextVisitor()

	// MARK: - Private Properties

	private let document: Document

	// MARK: - Initialization

	/// Initializes a new TaskScaneer with a given document.
	/// - Returns: The document to scan for tasks.
	init(document: Document) {
		self.document = document
	}

	// MARK: - Public Methods

	/// Scans the document and returns a list of tasks found within.
	/// - Returns: An array of 'Task' instances extracted from the document.
	func getTasks() -> [Task] {
		scan(document: document)
	}
}

private extension TaskScanner {
	func scan(document: Document) -> [Task] {
		var result = [Task]()

		document.children.forEach { node in
			if let task = node as? TaskNode {
				result.append(taskNodeToRegularTask(task: task))
			}
		}

		return result
	}

	func taskNodeToRegularTask(task: TaskNode) -> RegularTask {
		let text = visitor.visitChildren(of: task)
		return RegularTask(title: text.joined().string, completed: task.isDone)
	}
}
