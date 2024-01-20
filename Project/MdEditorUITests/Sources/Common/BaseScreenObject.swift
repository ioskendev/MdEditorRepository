//
	//  BaseScreenObject.swift
	//  MdEditorUITests
	//
	//  Created by Alexey Turulin on 1/18/24.
	//  Copyright © 2024 repakuku. All rights reserved.
	//

	import XCTest

	class BaseScreenObject {

		// MARK: - Dependencies

		let app: XCUIApplication

		// MARK: - Private properties

		private static let defaultTimeout: TimeInterval = 2

		// MARK: - Initialization

		init(app: XCUIApplication) {
			self.app = app
		}

		// MARK: - ScreenObject Methods

		@discardableResult
		func assert(_ element: XCUIElement, _ predicates: [Predicate], timeout: TimeInterval = defaultTimeout) -> Self {
			let expectation = XCTNSPredicateExpectation(
				predicate: NSPredicate(format: predicates.map { $0.format }.joined(separator: " AND ")),
				object: element
			)

			guard XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed else {
				XCTFail("[\(self)] Element \(element.description) doesn't conform the expectation: \(predicates.map { $0.format })")
				return self
			}

			return self
		}
	}
