//
//  TasksTests.swift
//
//
//  Created by Maxim Alekseev on 06.01.2024.
//

import XCTest
@testable import TaskManagerPackage

final class TasksTests: XCTestCase {

	func test_initTask() throws {

		let sut = Task(title: "Foo", completed: true)

		XCTAssertTrue(sut.title == "Foo", "Некорректная инициализация названия задачи")
		XCTAssertTrue(sut.completed, "Некорректная инициализация флага выполнения задачи")
	}

	func test_initImportantTask() throws {

		let sut = ImportantTask(title: "Foo", taskPriority: .high)

		XCTAssertTrue(sut.title == "Foo", "Некорректная инициализация названия важной задачи")
		XCTAssertTrue(sut.taskPriority == .high, "Некорректная инициализация приоритета важной задачи")
	}

	func test_deadline_withPriorityHigh_importantTask() throws {
		let creationDate  = Date()
		let sut = ImportantTask(title: "Foo", taskPriority: .high, createDate: creationDate)
		let desiredDeadline = Calendar.current.date(byAdding: .day, value: 1, to: creationDate)

		XCTAssertEqual(
			sut.deadLine, desiredDeadline,
			"Некоректный dedline при создании important task c priority high"
		)
	}

	func test_deadline_withPriorityMedium_importantTask() throws {
		let creationDate  = Date()
		let sut = ImportantTask(title: "Foo", taskPriority: .medium, createDate: creationDate)
		let desiredDeadline = Calendar.current.date(byAdding: .day, value: 2, to: creationDate)

		XCTAssertEqual(
			sut.deadLine, desiredDeadline,
			"Некоректный dedline при создании important task c priority medium"
		)
	}

	func test_deadline_withPriorityLow_importantTask() throws {
		let creationDate  = Date()
		let sut = ImportantTask(title: "Foo", taskPriority: .low, createDate: creationDate)
		let desiredDeadline = Calendar.current.date(byAdding: .day, value: 3, to: creationDate)

		XCTAssertEqual(
			sut.deadLine, desiredDeadline,
			"Некоректный dedline при создании important task c priority low"
		)
	}
}
