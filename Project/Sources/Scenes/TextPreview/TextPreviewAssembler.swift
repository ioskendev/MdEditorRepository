//
//  TextPreviewAssembler.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/10/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit
import MarkdownPackage

final class TextPreviewAssembler {

	// MARK: - Dependencies

	private let file: File
	private let converter: IMarkdownToAttributedStringConverter

	// MARK: - Initializers

	init(
		file: File,
		converter: IMarkdownToAttributedStringConverter
	) {
		self.file = file
		self.converter = converter
	}

	// MARK: - Public methods

	func assembly() -> TextPreviewViewController {
		let viewController = TextPreviewViewController()
		let presenter: ITextPreviewPresenter = TextPreviewPresenter(
			viewController: viewController,
			converter: converter
		)
		let interactor: ITextPreviewInteractor = TextPreviewInteractor(
			presenter: presenter,
			file: file
		)
		viewController.interactor = interactor

		return viewController
	}
}
