//
//  TextPreviewPresenter.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/10/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation
import MarkdownPackage

protocol ITextPreviewPresenter {
	func present(response: TextPreviewModel.Response)
}

final class TextPreviewPresenter: ITextPreviewPresenter {

	// MARK: - Dependencies

	private weak var viewController: ITextPreviewViewController?
	private let converter: IMarkdownToAttributedStringConverter

	// MARK: - Initialization

	init(
		viewController: TextPreviewViewController,
		converter: IMarkdownToAttributedStringConverter
	) {
		self.viewController = viewController
		self.converter = converter
	}

	// MARK: - Public Methods

	func present(response: TextPreviewModel.Response) {
		let attributedText = converter.convert(markdownText: response.fileContent)

		let viewModel = TextPreviewModel.ViewModel(
			currentTitle: response.fileUrl.lastPathComponent,
			text: attributedText
		)
		viewController?.render(viewModel: viewModel)
	}
}
