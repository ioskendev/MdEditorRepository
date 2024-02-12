//
//  MainPresenter.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/5/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

enum NextScreen {
	case open
	case about
}

protocol IMainPresenter {
	func present(response: MainModel.Response)
	func presentAboutScreen()
	func presentOpenScreen()
}

final class MainPresenter: IMainPresenter {

	// MARK: - Dependencies

	private weak var viewController: IMainViewController?
	private let closure: ((NextScreen) -> Void)?

	// MARK: - Initialization

	init(viewController: IMainViewController, closure: ((NextScreen) -> Void)?) {
		self.viewController = viewController
		self.closure = closure
	}

	// MARK: - Public Methods

	func present(response: MainModel.Response) {
		var onlyFiles = [MainModel.ViewModel.File]()

		for file in response.files {
			let file = MainModel.ViewModel.File(name: file.name)
			onlyFiles.append(file)
		}

		let viewModel = MainModel.ViewModel(recentFiles: onlyFiles)
		viewController?.render(viewModel: viewModel)
	}

	func presentAboutScreen() {
		closure?(.about)
	}

	func presentOpenScreen() {
		closure?(.open)
	}
}
