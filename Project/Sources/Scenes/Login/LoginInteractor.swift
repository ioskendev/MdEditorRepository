//
//  LoginInteractor.swift
//  MdEditor
//
//  Created by Alexey Turulin on 12/04/23.
//

import Foundation

protocol ILoginInteractor {
	func login(request: LoginModel.Request)
}

final class LoginInteractor: ILoginInteractor {

	// MARK: - Dependencies

	private let presenter: ILoginPresenter
	private let worker: ILoginWorker

	// MARK: - Initialization

	init(presenter: ILoginPresenter, worker: ILoginWorker) {
		self.presenter = presenter
		self.worker = worker
	}

	// MARK: - Public methods

	func login(request: LoginModel.Request) {
		let result = worker.login(login: request.login, password: request.password)
		let responce = LoginModel.Response(result: result)

		presenter.present(responce: responce)
	}
}
