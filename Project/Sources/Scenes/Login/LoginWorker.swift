//
//  LoginWorker.swift
//  MdEdit
//
//  Created by ioskendev on 12.01.2024.
//

import Foundation

protocol ILoginWorker {

	/// User autorisation.
	/// - Parameters:
	///   - login: User login.
	///   - password: User password.
	/// - Returns: Autorisation result.
	func login(login: String, password: String) -> Result<Void, LoginError>
}

enum LoginError: Error {
	case wrongLoginOrPassword
}

final class LoginWorker: ILoginWorker {

	// MARK: - Private properties

	private let validLogin = "Admin"
	private let validPassword = "pa$$32!"

	// MARK: - Public methods

	/// Авторизация пользователя.
	/// - Parameters:
	///   - login: Логин пользователя.
	///   - password: Пароль пользователя.
	/// - Returns: Результат прохождения авторизации.
	func login(login: String, password: String) -> Result<Void, LoginError> {

		if login == validLogin && password == validPassword {
			return .success(())
		} else {
			return .failure(.wrongLoginOrPassword)
		}
	}
}

class StubLoginWorker: ILoginWorker {
	func login(login: String, password: String) -> Result<Void, LoginError> {
		.success(())
	}
}
