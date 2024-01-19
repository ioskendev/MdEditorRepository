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

		override class func setUp() {
			let app = XCUIApplication()

			app.launchArguments = [LaunchArguments.enableTesting.rawValue]
			app.launchArguments = ["-AppleLanguages", "(en)"]
		}

		override func setUp() {
			super.setUp()
			app.launch()
		}

		override func tearDown() {
			app.terminate()
			super.tearDown()
		}

		func test_login_withInvalidCredentials_mustBeFailure() {

			let loginScreen = LoginScreenObject(app: app)

			loginScreen
				.isLoginScreen()
				.set(login: "invalidUsername")
				.set(password: "invalidPassword")
				.login()
				.invalidAttempt()
		}

		func test_login_withValidCredentials_mustBeSuccess() {

			let loginScreen = LoginScreenObject(app: app)

			loginScreen
				.isLoginScreen()
				.set(login: "Admin")
				.set(password: "pa$$32!")
				.login()
				.validAttempt()
		}
	}
