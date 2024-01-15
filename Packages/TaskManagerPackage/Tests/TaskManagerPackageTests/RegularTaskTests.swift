//
//  RegularTaskTests.swift
//  
//
//  Created by Alexey Turulin on 1/13/24.
//

import XCTest
@testable import TaskManagerPackage

final class RegularTaskTests: XCTestCase {

	func test_init_withTitleAndCompleted_shouldHaveCorrect() {
		let sut = RegularTask(title: title, completed: true)

		XCTAssertEqual(sut.title, title, "The task title should match the provided title.")
		XCTAssertTrue(sut.completed, "The task status should match the provided status.")
	}

	func test_init_defaultCompleted_propertyCompletedShouldbeFalse() {
		let sut = RegularTask(title: title)

		XCTAssertFalse(sut.completed, "The default completed property should be false")
	}

	func test_init_withTitleNotCompleted_shouldHaveCorrect() {
		let sut = RegularTask(title: title, completed: false)

		XCTAssertEqual(sut.title, title, "The task title should match the provided title.")
		XCTAssertFalse(sut.completed, "The task should not be marked as completed.")
	}

	func test_completed_togglePropertyCompleted_propertyCompletedShouldBeTrue() {
		let sut = RegularTask(title: title, completed: false)

		sut.completed.toggle()

		XCTAssertTrue(sut.completed, "Toggled the completed property should make the task completed.")
	}
}

// MARK: - TestData

private extension RegularTaskTests {
	var title: String {
		"Regular Test Task"
	}
}
