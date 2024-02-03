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
	
	private lazy var tableView = app.tables[AccessibilityIdentifier.TodoListScene.table.description]
	
	// MARK: - ScreenObject Methods
	
	@discardableResult
	func isTodoListScreen() -> Self {
		checkTitle(contains: L10n.TodoList.title)
		assert(tableView, [.exists])
		
		return self
	}
	
	@discardableResult
	func checkSectionTitle(index: Int, title: String) -> Self {
		let section = getSection(index: index)
		assert(section, [.exists])
		
		XCTAssertEqual(section.label, title, "Title section \(index) should be equal '\(title)'.")
		
		return self
	}
	
	@discardableResult
	func checkCellTitle(section: Int, row: Int, title: String) -> Self {
		let cell = getCell(section: section, row: row)
		assert(cell, [.exists])
		
		let titleTaskLabel = cell.staticTexts.element(boundBy: 0).label
		let contains = titleTaskLabel.contains(title)
		
		XCTAssertTrue(contains, "title task \(titleTaskLabel) should be equal '\(title)'.")
		return self
	}
	
	@discardableResult
	func checkCellDeadline(section: Int, row: Int, deadline: String) -> Self {
		let cell = getCell(section: section, row: row)
		assert(cell, [.exists])
		
		let taskDeadline = cell.staticTexts.element(boundBy: 1).label
		let contains = taskDeadline.contains(deadline)
		
		XCTAssertTrue(contains, "Cell [ \(section):\(row)] should contain '\(deadline)'.")
		
		return self
	}
	
	@discardableResult
	func tapOnCell(section: Int, row: Int) -> Self {
		let cell = getCell(section: section, row: row)
		assert(cell, [.exists])
		cell.tap()
		
		return self
	}
	
	@discardableResult
	func checkCountOfSelectedItems(_ count: Int) -> Self {
		assert(tableView, [.exists])
		let selected = tableView.children(matching: .cell).allElementsBoundByIndex.filter { $0.isSelected }
		
		XCTAssertEqual(selected.count, count, "Expected \(count) selected items, but found \(selected.count)")
		
		return self
	}
	
	@discardableResult
	func checkCountOfNotSelectedItems(_ count: Int) -> Self {
		assert(tableView, [.exists])
		let notSelected = tableView.children(matching: .cell).allElementsBoundByIndex.filter { !$0.isSelected }
		
		XCTAssertEqual(notSelected.count, count, "Expected \(count) selected items, but found \(notSelected.count)")
		
		return self
	}
}

private extension TodoListScreenObject {
	func getSection(index: Int) -> XCUIElement {
		tableView.otherElements[AccessibilityIdentifier.TodoListScene.section(index).description]
	}
	
	func getCell(section: Int, row: Int) -> XCUIElement {
		tableView.cells[AccessibilityIdentifier.TodoListScene.cell(section: section, row: row).description]
	}
}
