//
//  TodoListScreenObject.swift
//  MdEditorUITests
//
//  Created by Alexey Turulin on 1/20/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import XCTest

final class TodoListScreenObject: BaseScreenObject {

	// MARK: - Private properties

	private lazy var navigationBar = app.navigationBars.firstMatch
	private lazy var navigationBarTitle = navigationBar.staticTexts.firstMatch

	private lazy var tableView = app.tables.element
	private lazy var uncompletedTitle = tableView.staticTexts["Uncompleted"]
	private lazy var completedTitle = tableView.staticTexts["Completed"]

	// MARK: - ScreenObject Methods

	@discardableResult
	func isTodoListScreen() -> Self {
		assert(navigationBarTitle, [.contains("ToDoList")])

		return self
	}

	@discardableResult
	func validHeaderTitles() -> Self {

		let otherElements = tableView.otherElements.allElementsBoundByIndex
		let sections = otherElements.filter { $0.identifier.contains("Section") }

		XCTAssertEqual(sections.count, 2, "Expected 2 sections, but found \(sections)")
		assert(uncompletedTitle, [.exists])
		assert(completedTitle, [.exists])

		return self
	}
}
