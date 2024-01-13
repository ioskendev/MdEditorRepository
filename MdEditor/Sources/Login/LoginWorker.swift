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

// TODO: login error transport to delete
enum LoginError: Error {
	case wrongPassword
	case wrongLogin
	case errorAuth
	case emptyFields
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
		guard !login.isEmpty, !password.isEmpty else { return .failure(.emptyFields) }

		switch (login == validLogin, password == validPassword) {
		case (true, true):
			return .success(())
		case (false, true):
			return .failure(.wrongLogin)
		case (true, false):
			return .failure(.wrongPassword)
		case (false, false):
			return .failure(.errorAuth)
		}
	}
}

class StubLoginWorker: ILoginWorker {
	func login(login: String, password: String) -> Result<Void, LoginError> {
		.success(())
	}
}
