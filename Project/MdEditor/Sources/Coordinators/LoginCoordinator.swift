//
//  LoginCoordinator.swift
//  MdEdit
//
//  Created by ioskendev on 12.01.2024.
//

import UIKit

protocol ILoginCoordinator: ICoordinator {

	/// Finish flow method
	var finishFlow: (() -> Void)? { get set }
}

final class LoginCoordinator: ILoginCoordinator {

	// MARK: - Dependencies

	var navigationController: UINavigationController

	// MARK: - Internal properties

	var finishFlow: (() -> Void)?

	// MARK: - Initialization

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Internal methods

	func start() {
		showLoginScene()
	}

	func showLoginScene() {
		let viewController = LoginAssembler().assembly { [weak self] result in
			switch result {
			case .success:
				self?.finishFlow?()
			case .failure(let error):
				self?.showError(message: error.localizedDescription)
			}
		}
		navigationController.pushViewController(viewController, animated: true)
	}

	func showError(message: String) {
		let alert = UIAlertController(title: L10n.Error.text, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: L10n.Ok.text, style: .default)
		alert.addAction(action)
		navigationController.present(alert, animated: true, completion: nil)
	}
}
