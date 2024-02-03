//
//  TodoListSceneUITests.swift
//  MdEditorUITests
//
//  Created by Alexey Turulin on 1/20/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import XCTest

final class TodoListSceneUITests: XCTestCase {
	
	private let app = XCUIApplication()
	private lazy var screen = TodoListScreenObject(app: app)
	
	override func setUp() {
		super.setUp()
		continueAfterFailure = false
		app.launchArguments = [LaunchArguments.skipLogin.rawValue]
		
		app.launch()
	}
	
	func test_sectionTitles_mustBeValidTitle() {
		screen
			.isTodoListScreen()
			.checkSectionTitle(index: 0, title: L10n.TodoList.Section.uncompleted)
			.checkSectionTitle(index: 1, title: L10n.TodoList.Section.completed)
	}
	
	func test_taskCountAndTitles_mustBeValidCountAndTitles() {
		screen
			.isTodoListScreen()
			.checkCountOfSelectedItems(1)
			.checkCountOfNotSelectedItems(4)
			.checkCellTitle(section: 0, row: 0, title: L10n.Task.doHomework)
			.checkCellTitle(section: 0, row: 1, title: L10n.Task.goShopping)
			.checkCellTitle(section: 0, row: 2, title: L10n.Task.writeNewTasks)
			.checkCellTitle(section: 0, row: 3, title: L10n.Task.solve3Algorithms)
			.checkCellTitle(section: 1, row: 0, title: L10n.Task.doWorkout)
	}
	
	func test_doTaskCompleted_mustBeCompleted() {
		screen
			.isTodoListScreen()
			.tapOnCell(section: 0, row: 0)
			.checkCountOfSelectedItems(2)
			.checkCountOfNotSelectedItems(3)
			.checkCellTitle(section: 0, row: 0, title: L10n.Task.goShopping)
			.checkCellTitle(section: 0, row: 1, title: L10n.Task.writeNewTasks)
			.checkCellTitle(section: 0, row: 2, title: L10n.Task.solve3Algorithms)
			.checkCellTitle(section: 1, row: 0, title: L10n.Task.doHomework)
			.checkCellTitle(section: 1, row: 1, title: L10n.Task.doWorkout)
	}
	
	func test_undoTaskCompleted_mustBeUncompleted() {
		screen
			.isTodoListScreen()
			.tapOnCell(section: 1, row: 0)
			.checkCountOfSelectedItems(0)
			.checkCountOfNotSelectedItems(5)
			.checkCellTitle(section: 0, row: 0, title: L10n.Task.doHomework)
			.checkCellTitle(section: 0, row: 1, title: L10n.Task.goShopping)
			.checkCellTitle(section: 0, row: 2, title: L10n.Task.writeNewTasks)
			.checkCellTitle(section: 0, row: 3, title: L10n.Task.doWorkout)
			.checkCellTitle(section: 0, row: 4, title: L10n.Task.solve3Algorithms)
	}
}
