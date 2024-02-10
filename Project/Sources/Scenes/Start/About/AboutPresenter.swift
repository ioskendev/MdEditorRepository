//
//  AboutPresenter.swift
//  MdEditor
//
//  Created by Yuri Volegov on 08.02.2024.
//  Copyright © 2024 ioskendev. All rights reserved.
//

import Foundation

protocol IAboutPresenter {

	/// About screen presentation.
	/// - Parameter response: About model ro present.
	func present(responce: AboutModel.Response)
}

final class AboutPresenter: IAboutPresenter {

	// MARK: - Dependencies

	private weak var viewController: IAboutViewController?

	// MARK: - Initialization

	init(viewController: IAboutViewController?) {
		self.viewController = viewController
	}

	// MARK: - Public methods

	/// About scene presentation.
	/// - Parameter response: About model data to present.
	func present(responce: AboutModel.Response) {
		let viewModel = AboutModel.ViewModel(aboutText: responce.aboutText)
		viewController?.render(viewModel: viewModel)
	}
}
