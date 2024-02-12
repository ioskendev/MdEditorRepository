//
//  OpenPresenter.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/11/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

protocol IOpenPresenter {
	func present(response: OpenModel.Response)
	func presentMainScreen()
}

final class OpenPresenter: IOpenPresenter {

	// MARK: - Dependencies

	private weak var viewController: OpenViewController?
	private let backClosure: (() -> Void)?

	// MARK: - Initialization

	init(viewController: OpenViewController, backClosure: (() -> Void)?) {
		self.viewController = viewController
		self.backClosure = backClosure
	}

	// MARK: - Public Methods

	func present(response: OpenModel.Response) {
		let viewModel = OpenModel.ViewModel(files: [])
		viewController?.render(viewModel: viewModel)
	}

	func presentMainScreen() {
		backClosure?()
	}
}
