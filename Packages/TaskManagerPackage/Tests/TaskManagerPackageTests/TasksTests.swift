//
//  TasksTests.swift
//
//
//  Created by Alexey Turulin on 1/13/24.
//

import XCTest
@testable import TaskManagerPackage

final class TasksTests: XCTestCase {

	func test_init_withTitleAndCompleted_shouldHaveCorrect() {
		let sut = Task(title: title, completed: true)

		XCTAssertEqual(sut.title, title, "The task title should match the provided title.")
		XCTAssertTrue(sut.completed, "The task status should match the provided status.")
	}

	func test_init_defaultCompleted_propertyCompletedShouldbeFalse() {
		let sut = Task(title: title)

		XCTAssertFalse(sut.completed, "The default completed property should be false")
	}

	func test_init_withTitleNotCompleted_shouldHaveCorrect() {
		let sut = Task(title: title, completed: false)

		XCTAssertEqual(sut.title, title, "The task title should match the provided title.")
		XCTAssertFalse(sut.completed, "The task status should match the provided status.")
	}

	func test_completed_togglePropertyCompleted_propertyCompletedShouldBeTrue() {
		let sut = Task(title: title, completed: false)

		sut.completed.toggle()

		XCTAssertTrue(sut.completed, "Toggled the completed property should make the task completed.")
	}
}

// MARK: - TestData

private extension TasksTests {
	var title: String {
		"Test Task"
	}
}
