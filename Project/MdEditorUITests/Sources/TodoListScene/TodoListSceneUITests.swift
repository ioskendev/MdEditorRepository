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

	override class func setUp() {
		let app = XCUIApplication()

		app.launchArguments = [LaunchArguments.enableTesting.rawValue]
		app.launchArguments = ["-AppleLanguages", "(en)"]
	}

	override func setUp() {
		super.setUp()
		app.launch()

		let loginScreen = LoginScreenObject(app: app)

		loginScreen
			.isLoginScreen()
			.set(login: "Admin")
			.set(password: "pa$$32!")
			.login()
	}

	override func tearDown() {
		app.terminate()
		super.tearDown()
	}

	func test_headerTitles_mustBeCorrect() {

		let todoListScreen = TodoListScreenObject(app: app)

		todoListScreen
			.isTodoListScreen()
			.validHeaderTitles()
	}
}
