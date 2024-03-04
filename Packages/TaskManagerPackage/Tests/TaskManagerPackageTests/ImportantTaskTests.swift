//
//  ImportantTaskTests.swift
//  
//
//  Created by Alexey Turulin on 1/13/24.
//

import XCTest
@testable import TaskManagerPackage

final class ImportantTaskTests: XCTestCase {

	func test_init_shouldHaveCorrect() {
		let currentDate = Date()

		let sut = ImportantTask(title: title, taskPriority: .high, createDate: currentDate)

		XCTAssertEqual(sut.title, title, "The task title should match the provided title.")
		XCTAssertEqual(sut.taskPriority, .high, "The task priority should match the provided priority.")
		XCTAssertFalse(sut.completed, "The task status should match the provided status.")
	}

	func test_deadLine_lowPriorityTask() {
		let currentDate = Date()
		// swiftlint:disable:next force_unwrapping
		let deadLine = Calendar.current.date(byAdding: .day, value: 3, to: currentDate)!

		let sut = ImportantTask(title: title, taskPriority: .low, createDate: currentDate)

		XCTAssertEqual(sut.deadLine, deadLine, "Wrong deadLine for the task with the low priority.")
	}

	func test_deadLine_mediumPriorityTask() {
		let currentDate = Date()
		// swiftlint:disable:next force_unwrapping
		let deadLine = Calendar.current.date(byAdding: .day, value: 2, to: currentDate)!

		let sut = ImportantTask(title: title, taskPriority: .medium, createDate: currentDate)

		XCTAssertEqual(sut.deadLine, deadLine, "Wrong deadLine for the task with the medium priority.")
	}

	func test_deadLine_highPriorityTask() {
		let currentDate = Date()
		// swiftlint:disable:next force_unwrapping
		let deadLine = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!

		let sut = ImportantTask(title: title, taskPriority: .high, createDate: currentDate)

		XCTAssertEqual(sut.deadLine, deadLine, "Wrong deadLine for the task with the high priority.")
	}

	func test_completed_togglePropertyCompleted_propertyCompletedShouldBeTrue() {
		let sut = ImportantTask(title: title, taskPriority: .high)

		sut.completed.toggle()

		XCTAssertTrue(sut.completed, "Toggled the completed property should make the task completed.")
	}
}

// MARK: - TestData

private extension ImportantTaskTests {
	var title: String {
		"Important Test Task"
	}
}
