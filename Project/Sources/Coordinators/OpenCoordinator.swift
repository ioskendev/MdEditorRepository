//
//  OpenCoordinator.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/11/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit

final class OpenCoordinator: ICoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController

	// MARK: - Internal properties

	var finishFlow: (() -> Void)?

	// MARK: - Initialization

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Internal methods

	func start() {
		showOpenScene()
	}

	func showOpenScene() {
		let assembler = OpenAssembler()
		let viewController = assembler.assemble { [weak self] in
			self?.finishFlow?()
		}
		navigationController.pushViewController(viewController, animated: true)
	}
}
