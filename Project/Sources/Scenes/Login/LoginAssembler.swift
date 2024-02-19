//
//  LoginAssembler.swift
//  MdEditor
//
//  Created by Alexey Turulin on 12/04/23.
//

import UIKit

final class LoginAssembler {

	/// Сборка модуля авторизации
	/// - Parameter loginResultClosure: замыкание оповещающие о результате авторизации
	/// - Returns: вью
	func assembly(loginResultClosure: LoginResultClosure?) -> LoginViewController {
		let viewController = LoginViewController()
		let presenter = LoginPresenter(
			viewController: viewController,
			loginResultClosure: loginResultClosure
		)
		let worker = StubLoginWorker()
		let interactor = LoginInteractor(
			presenter: presenter,
			worker: worker
		)
		viewController.interactor = interactor

		return viewController
	}
}
