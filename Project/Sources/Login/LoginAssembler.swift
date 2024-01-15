//
//  LoginAssembler.swift
//  MdEdit
//
//  Created by ioskendev on 12.01.2024.
//

import UIKit

/// Assemble login scene
final class LoginAssembler {

	/// Assemby login scene
	/// - Parameter loginResultClosure: closure for end scene running
	/// - Returns: LoginViewController
	func assembly(loginResultClosure: LoginResultClosure?) -> LoginViewController {
		let viewController = LoginViewController()
		let presenter = LoginPresenter(viewController: viewController, loginResultClosure: loginResultClosure)
		let worker = StubLoginWorker()
		let interactor = LoginInteractor(presenter: presenter, worker: worker)
		viewController.interactor = interactor

		return viewController
	}
}
