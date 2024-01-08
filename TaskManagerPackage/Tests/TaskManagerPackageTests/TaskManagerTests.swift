//
//  TaskManagerTests.swift
//
//
//  Created by Maxim Alekseev on 06.01.2024.
//

import XCTest
@testable import TaskManagerPackage

final class TaskManagerTests: XCTestCase {

	private var stub: ITasksStub!
	private var sut: TaskManager!

	override func setUp() {
		stub = TasksStub()
		sut = TaskManager(taskList: stub.getTasks())
	}

	override func tearDown() {
		stub = nil
		sut = nil
	}

	func test_getTasks_tasksCountShouldBeEqualStubTaskCount() throws {

		let stubCount = stub.getTasks().count
		let sutCount = sut.allTasks().count

		XCTAssertEqual(
			sutCount,
			stubCount,
			"Количество задач в task manager не соответствует исходному значению"
		)
	}

	func test_completedTasks_countCompletedTasksShouldBeEqualCountCompletedTasksInStub() throws {

		let countCompletedTasksInStub = stub.getTasks().filter { $0.completed }.count
		let countCompletedTasksInSut = sut.completedTasks().count

		XCTAssertEqual(
			countCompletedTasksInSut,
			countCompletedTasksInStub,
			"Количество завершенных задач в task manager не соответствует исходным параметрам"
		)
	}

	func test_uncompletedTaskscountUncompletedTasksShouldBeEqualCountUncompletedTasksInStub() throws {

		let countUncompletedTasksInStub = stub.getTasks().filter { !$0.completed }.count
		let countUncompletedTasksInSut = sut.uncompletedTasks().count

		XCTAssertEqual(
			countUncompletedTasksInSut,
			countUncompletedTasksInStub,
			"Количество незавершенных задач в task manager не соответствует исходным параметрам"
		)
	}

	func test_addTask_withNewTask_sutShouldContainNewTask() throws {

		let task = Task(title: "Foo")

		sut.addTask(task: task)

		XCTAssert(
			sut.allTasks().contains { $0 === task },
			"В task manager не добавляется новая запись"
		)
	}

	func test_addTasks_withNewTasks_sutShouldContainNewTasks() throws {

		let tasks = [Task(title: "Foo"), Task(title: "Bar")]

		sut.addTasks(tasks: tasks)
		let sutContainAddedTasks = sut
			.allTasks()
			.contains { $0 === tasks[0]}
		&& sut
			.allTasks()
			.contains { $0 === tasks[1] }

		XCTAssert(
			sutContainAddedTasks,
			"Task manager не содержит добавленных записей"
		)
	}

	func test_removeTask_whithTask_sutShouldNotContainTask() throws {

		let task = Task(title: "Foo")

		sut.addTask(task: task)
		sut.removeTask(task: task)
		let sutContainRemovedTask = sut.allTasks().contains { $0 === task }

		XCTAssertFalse(
			sutContainRemovedTask,
			"Task manager не должен содержать удаленной задачи"
		)
	}
}
