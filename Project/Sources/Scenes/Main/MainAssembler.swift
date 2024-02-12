//
//  MainAssembler.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/5/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit

final class MainAssembler {

	// MARK: - Dependencies

	private let fileExplorer: IFileExplorer

	// MARK: - Initializers

	init(fileExplorer: IFileExplorer) {
		self.fileExplorer = fileExplorer
	}

	// MARK: - Public methods

	func assembly(closure: ((NextScreen) -> Void)?) -> MainViewController {
		let viewController = MainViewController()
		let presenter = MainPresenter(
			viewController: viewController,
			closure: closure
		)
		let interactor = MainInteractor(presenter: presenter, fileExplorer: fileExplorer)
		viewController.interactor = interactor

		return viewController
	}
}
