//
//  StartCoordinator.swift
//  MdEditor
//
//  Created by Maxim Alekseev on 03.02.2024.
//  Copyright © 2024 ioskendev. All rights reserved.
//

import UIKit

protocol IStartCoordinator: ICoordinator {

	/// Finish flow method
	var finishFlow: (() -> Void)? { get set }
}

final class StartCoordinator: IStartCoordinator {

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
		showStartScene()
	}

	func showStartScene() {
		let viewController = StartAssembler().assembly { [weak self] in
			guard let self = self else { return }
			finishFlow?()
		}
		navigationController.setViewControllers([viewController], animated: true)
	}
}
