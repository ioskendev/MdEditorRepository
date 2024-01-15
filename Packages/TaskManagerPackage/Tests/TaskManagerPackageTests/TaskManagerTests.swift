//
//  TaskManagerTests.swift
//
//
//  Created by Alexey Turulin on 1/13/24.
//

import XCTest
@testable import TaskManagerPackage

final class TaskManagerTests: XCTestCase {

	private let completedTask = Task(title: "completedTask", completed: true)
	private let uncompletedTask = Task(title: "uncompletedTask", completed: false)

	func test_allTasks_addTwoTasks_shouldBeTwoTasks() {
		let sut = makeSUT()

		let allTasks = sut.allTasks()

		XCTAssertEqual(allTasks.count, 2, "Expected 2 tasks, but found \(allTasks.count).")
		XCTAssertTrue(allTasks.contains { $0 === completedTask }, "Completed task not found in the task list.")
		XCTAssertTrue(allTasks.contains { $0 === uncompletedTask }, "Uncompleted task not found in the task list." )
	}

	func test_completedTasks_add1CompletedAnd1Uncompleted_shouldBe1Task() {
		let sut = makeSUT()

		let completedTasks = sut.completedTasks()

		XCTAssertEqual(completedTasks.count, 1, "Expected 1 completed task, but found \(completedTasks.count).")
		XCTAssertTrue(completedTasks.contains { $0 === completedTask }, "Completed task not found in the completed task list.")
		XCTAssertFalse(completedTasks.contains { $0 === uncompletedTask}, "Uncompleted task found in the completed task list.")
	}

	func test_uncompletedTasks_add1CompletedAnd1Uncompleted_shouldBe1Task() {
		let sut = makeSUT()

		let uncompletedTasks = sut.uncompletedTasks()

		XCTAssertEqual(uncompletedTasks.count, 1, "Expected 1 uncompleted task, but found \(uncompletedTasks.count).")
		XCTAssertTrue(uncompletedTasks.contains { $0 === uncompletedTask }, "Uncompleted task not found in the uncompleted task list.")
		XCTAssertFalse(uncompletedTasks.contains { $0 === completedTask}, "Completed task found in the uncompleted task list.")
	}

	func test_addTask_add1Task_ShouldBe1Task() {
		let sut = TaskManager()

		sut.addTask(task: uncompletedTask)
		let allTasks = sut.allTasks()

		XCTAssertTrue(allTasks.contains { $0 === uncompletedTask }, "Task not added successfully.")
	}

	func test_addTasks_add2Task_ShouldBe2Task() {
		let sut = TaskManager()

		sut.addTasks(tasks: [completedTask, uncompletedTask])
		let allTasks = sut.allTasks()

		XCTAssertEqual(allTasks.count, 2, "Expected 2 tasks, but found \(allTasks.count).")
		XCTAssertTrue(allTasks.contains { $0 === completedTask }, "Completed task not found in the task list.")
		XCTAssertTrue(allTasks.contains { $0 === uncompletedTask }, "Uncompleted task not found in the task list.")
	}

	func test_removeTask_add2TasksAndRemove1Task_shouldBe1Task() {
		let sut = makeSUT()

		sut.removeTask(task: completedTask)
		let allTasks = sut.allTasks()

		XCTAssertEqual(allTasks.count, 1, "Expected 1 task after removal, but found \(allTasks.count).")
		XCTAssertFalse(allTasks.contains { $0 === completedTask }, "Removed task still found in the task list.")
		XCTAssertTrue(allTasks.contains { $0 === uncompletedTask }, "Unremoved task not found in the task list.")
	}
}

// MARK: - TestData

private extension TaskManagerTests {
	func makeSUT() -> TaskManager {
		TaskManager(taskList: [completedTask, uncompletedTask])
	}
}
