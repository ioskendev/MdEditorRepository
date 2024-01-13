//
//  File.swift
//  
//
//  Created by Maxim Alekseev on 06.01.2024.
//

import XCTest
@testable import TaskManagerPackage

private enum ImportantTasksError: Error {
	case castAsImportantTaskFail

	var description: String {
		switch self {
		case .castAsImportantTaskFail:
			return "Не удалось выполнить преобразование в Important Task"
		}
	}
}

final class OrderedTaskManagerTests: XCTestCase {

	private var stub: ITasksStub!
	private var sut: OrderedTaskManager!

	override func setUp() {
		stub = TasksStub()
		let taskManager = TaskManager(taskList: stub.getTasks())
		sut = OrderedTaskManager(taskManager: taskManager)
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
			"Количество задач в ordered task manager не соответствует исходному значению"
		)
	}

	func test_completedTasks_countCompletedTasksShouldBeEqualCountCompletedTasksInStub() throws {

		let countCompletedTasksInStub = stub.getTasks().filter { $0.completed }.count
		let countCompletedTasksInSut = sut.completedTasks().count

		XCTAssertEqual(
			countCompletedTasksInSut,
			countCompletedTasksInStub,
			"Количество завершенных задач в ordered task manager не соответствует исходным параметрам"
		)
	}

	func test_uncompletedTaskscountUncompletedTasksShouldBeEqualCountUncompletedTasksInStub() throws {

		let countUncompletedTasksInStub = stub.getTasks().filter { !$0.completed }.count
		let countUncompletedTasksInSut = sut.uncompletedTasks().count

		XCTAssertEqual(
			countUncompletedTasksInSut,
			countUncompletedTasksInStub,
			"Количество незавершенных задач в ordered task manager не соответствует исходным параметрам"
		)
	}

	func test_addTask_withNewTask_sutShouldContainNewTask() throws {

		let task = Task(title: "Foo")

		sut.addTask(task: task)

		XCTAssert(
			sut.allTasks().contains { $0 === task },
			"В ordered task manager не добавляется новая запись"
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
			"Ordered Task manager не содержит добавленных записей"
		)
	}

	func test_removeTask_whithTask_sutShouldNotContainTask() throws {

		let task = Task(title: "Foo")

		sut.addTask(task: task)
		sut.removeTask(task: task)
		let sutContainRemovedTask = sut.allTasks().contains { $0 === task }

		XCTAssertFalse(
			sutContainRemovedTask,
			"Ordered Task manager не должен содержать удаленной задачи"
		)
	}

	func test_sorted_withTasks_taskWithHighestPriorityShouldBeInTheBeginnnigOfTaskList() throws {

		let tasks = [
			ImportantTask(title: "Foo", taskPriority: .low),
			ImportantTask(title: "Bar", taskPriority: .medium),
			ImportantTask(title: "Baz", taskPriority: .high)
		]
		let sut = OrderedTaskManager(taskManager: TaskManager(taskList: tasks))
		guard let sortedTasks = sut.allTasks() as? [ImportantTask] else {
			throw ImportantTasksError.castAsImportantTaskFail
		}

		XCTAssert(
			sortedTasks[0].taskPriority == .high,
			"Не работает сортировка по приоритету в Ordered Task manager"
		)
		XCTAssert(
			sortedTasks[1].taskPriority == .medium,
			"Не работает сортировка по приоритету в Ordered Task manager"
		)
		XCTAssert(
			sortedTasks[2].taskPriority == .low,
			"Не работает сортировка по приоритету в Ordered Task manager"
		)
	}

	func test_sorted_withTasks_importantTasksShouldBeInTheBegginingOfListRegularAtTheEnd() throws {
		let tasks = [
			RegularTask(title: "Foo"),
			ImportantTask(title: "Bar", taskPriority: .medium)
		]
		let sut = OrderedTaskManager(taskManager: TaskManager(taskList: tasks))
		let isFirstImportantTask = sut.allTasks()[0] === tasks[1]

		XCTAssertTrue(isFirstImportantTask, "Неккоректная сортировка important task с regular task")
	}
}
