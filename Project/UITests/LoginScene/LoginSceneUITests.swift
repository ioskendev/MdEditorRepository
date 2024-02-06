//
//  SomeTest.swift
//  MdEditorUITests
//
//  Created by Alexey Turulin on 1/16/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import XCTest

final class LoginSceneUITests: XCTestCase {

	private let app = XCUIApplication()
	private lazy var screen = LoginScreenObject(app: app)

	override func setUp() {
		super.setUp()
		continueAfterFailure = false

		app.launch()
	}

	func test_login_withInvalidCredentials_mustBeFailure() {
		screen
			.isLoginScreen()
			.set(login: ConfigureTestEnvironment.InvalidCredentials.login)
			.set(password: ConfigureTestEnvironment.InvalidCredentials.password)
			.login()
			.closeAlert()
			.isLoginScreen()
	}

	func test_login_withValidCredentials_mustBeSuccess() {
		let todoListScreenObject = TodoListScreenObject(app: app)

		screen
			.isLoginScreen()
			.set(login: ConfigureTestEnvironment.ValidCredentials.login)
			.set(password: ConfigureTestEnvironment.ValidCredentials.password)
			.login()

		todoListScreenObject
			.isTodoListScreen()
	}
}
