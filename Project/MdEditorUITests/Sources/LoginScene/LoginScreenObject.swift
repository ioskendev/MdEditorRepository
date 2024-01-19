//
	//  LoginScreenObject.swift
	//  MdEditorUITests
	//
	//  Created by Alexey Turulin on 1/18/24.
	//  Copyright © 2024 repakuku. All rights reserved.
	//

	import XCTest

	final class LoginScreenObject: BaseScreenObject {

		// MARK: - Private properties

		private lazy var textFieldLogin = app.textFields[AccessibilityIdentifier.textFieldLogin.rawValue]
		private lazy var textFieldPass = app.secureTextFields[AccessibilityIdentifier.textFieldPass.rawValue]
		private lazy var loginButton = app.buttons[AccessibilityIdentifier.buttonLogin.rawValue]

		private lazy var alert = app.alerts.firstMatch
		private lazy var alertButton = alert.buttons.firstMatch

		private lazy var navigationBar = app.navigationBars.firstMatch
		private lazy var navigationBarTitle = navigationBar.staticTexts.firstMatch

		// MARK: - ScreenObject Methods

		@discardableResult
		func isLoginScreen() -> Self {
			assert(textFieldLogin, [.exists])
			assert(textFieldPass, [.exists])
			assert(loginButton, [.exists])

			return self
		}

		@discardableResult
		func set(login: String) -> Self {
			assert(textFieldLogin, [.exists])
			textFieldLogin.tap()
			textFieldLogin.typeText(login)

			return self
		}

		@discardableResult
		func set(password: String) -> Self {
			assert(textFieldPass, [.exists])
			textFieldPass.tap()
			textFieldPass.typeText(password)

			return self
		}

		@discardableResult
		func login() -> Self {
			assert(loginButton, [.exists])
			loginButton.tap()

			return self
		}

		@discardableResult
		func invalidAttempt() -> Self {
			assert(alert, [.exists])
			alertButton.tap()
			assert(navigationBarTitle, [.contains("Authorization")])

			return self
		}

		@discardableResult
		func validAttempt() -> Self {
			assert(navigationBarTitle, [.contains("ToDoList")])

			return self
		}
	}
