//
//  TextPreviewAssembler.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/10/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit

final class TextPreviewAssembler {

	// MARK: - Dependencies

	private let file: File

	// MARK: - Initializers

	init(file: File) {
		self.file = file
	}

	// MARK: - Public methods

	func assembly() -> TextPreviewViewController {
		let viewController = TextPreviewViewController()
		let presenter: ITextPreviewPresenter = TextPreviewPresenter(viewController: viewController)
		let interactor: ITextPreviewInteractor = TextPreviewInteractor(
			presenter: presenter,
			file: file
		)
		viewController.interactor = interactor

		return viewController
	}
}
