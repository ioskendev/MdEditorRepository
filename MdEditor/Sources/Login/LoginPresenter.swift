//
//  LoginPresenter.swift
//  MdEdit
//
//  Created by Yuri Volegov on 12.01.2024.
//

import Foundation

protocol ILoginPresenter {

	/// Login screen presentation.
	/// - Parameter response: Login model ro present.
	func present(responce: LoginModel.Response)
}

typealias LoginResultClosure = (Result<Void, LoginError>) -> Void

final class LoginPresenter: ILoginPresenter {

	// MARK: - Dependencies

	private weak var viewController: ILoginViewController?
	private var loginResultClosure: LoginResultClosure?

	// MARK: - Initialization

	init(viewController: ILoginViewController?, loginResultClosure: LoginResultClosure?) {
		self.viewController = viewController
		self.loginResultClosure = loginResultClosure
	}

	// MARK: - Public methods

	/// Login scene presentation.
	/// - Parameter response: Login model data to present.
	func present(responce: LoginModel.Response) {
		loginResultClosure?(responce.result)
	}
}

extension LoginError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .wrongPassword:
			return "Неверный пароль."
		case .wrongLogin:
			return "Неверный логин."
		case .emptyFields:
			return "Пустые поля логин или пароль."
		case .errorAuth:
			return "Неверный пароль и логин."
		}
	}
}
