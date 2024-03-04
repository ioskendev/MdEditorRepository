//
//  OrderedTaskManagerTests.swift
//
//
//  Created by Alexey Turulin on 1/13/24.
//

import XCTest
@testable import TaskManagerPackage

final class OrderedTaskManagerTests: XCTestCase {

	func test_allTasks_shouldBe5TaskOrderedByPriority() {
		let sut = makeSUT()

		let validResultTasks: [TaskManagerPackage.Task] = [
			MockTaskManager.highImportantTask,
			MockTaskManager.mediumImportantTask,
			MockTaskManager.lowImportantTask,
			MockTaskManager.completedRegularTask,
			MockTaskManager.uncompletedRegularTask
		]

		let resultTasks = sut.allTasks()

		XCTAssertEqual(resultTasks.count, 5, "Expected 5 tasks, but found \(resultTasks.count).")
		XCTAssertEqual(resultTasks, validResultTasks, "Tasks are not ordered correctly.")
	}

	func test_completedTasks_shouldBeAllCompletedTaskOrderedByPriority() {
		let sut = makeSUT()

		let validResultTasks: [TaskManagerPackage.Task] = [MockTaskManager.completedRegularTask]

		let resultTasks = sut.completedTasks()

		XCTAssertEqual(resultTasks.count, 1, "Expected 1 completed task, but found \(resultTasks.count).")
		XCTAssertEqual(resultTasks, validResultTasks, "Completed tasks are not ordered correctly.")
	}

	func test_uncompletedTasks_shouldBeAllUncompletedTaskOrderedByPriority() {
		let sut = makeSUT()

		let validResultTasks: [TaskManagerPackage.Task] = [
			MockTaskManager.highImportantTask,
			MockTaskManager.mediumImportantTask,
			MockTaskManager.lowImportantTask,
			MockTaskManager.uncompletedRegularTask
		]

		let resultTasks = sut.uncompletedTasks()

		XCTAssertEqual(resultTasks.count, 4, "Expected 4 uncompleted tasks, but found \(resultTasks.count).")
		XCTAssertEqual(resultTasks, validResultTasks, "Uncompleted tasks are not ordered correctly.")
	}
}

// MARK: - TestData

private extension OrderedTaskManagerTests {
	func makeSUT() -> OrderedTaskManager {
		let mockTaskManager = MockTaskManager()
		let sut = OrderedTaskManager(taskManager: mockTaskManager)
		return sut
	}
}
