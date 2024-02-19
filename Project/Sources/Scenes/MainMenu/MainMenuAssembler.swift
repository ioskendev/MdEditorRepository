//
//  MainMenuAssembler.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/5/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit

final class MainMenuAssembler {

	// MARK: - Dependencies

	private let recentFileManager: IRecentFileManager

	// MARK: - Initializers

	init(
		recentFileManager: IRecentFileManager
	) {
		self.recentFileManager = recentFileManager
	}

	// MARK: - Public methods

	func assembly() -> (MainMenuViewController, MainMenuInteractor) {
		let viewController = MainMenuViewController()
		let presenter = MainMenuPresenter(viewController: viewController)
		let interactor = MainMenuInteractor(
			presenter: presenter,
			recentFileManager: recentFileManager
		)
		viewController.interactor = interactor

		return (viewController, interactor)
	}
}
