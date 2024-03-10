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

	private let converter = MarkdownToAttributedStringConverter(theme: AttributedTextColors())

	// MARK: - Initializers

	init(
		file: File
	) {
		self.file = file
	}

	// MARK: - Public methods

	func assembly() -> (TextPreviewViewController, TextPreviewInteractor) {
		let viewController = TextPreviewViewController()
		let presenter: ITextPreviewPresenter = TextPreviewPresenter(
			viewController: viewController,
			converter: converter
		)
		let interactor = TextPreviewInteractor(
			presenter: presenter,
			file: file
		)
		viewController.interactor = interactor

		return (viewController, interactor)
	}
}
