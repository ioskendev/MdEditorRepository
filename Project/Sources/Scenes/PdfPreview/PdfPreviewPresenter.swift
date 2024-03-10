//
//  PdfPreviewPresenter.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/10/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation
import MarkdownPackage

protocol IPdfPreviewPresenter {
	func present(response: PdfPreviewModel.Response)
}

final class PdfPreviewPresenter: IPdfPreviewPresenter {

	// MARK: - Dependencies

	private weak var viewController: IPdfPreviewController?
	private let converter: IMarkdownToPdfConverter

	// MARK: - Initialization

	init(
		viewController: PdfPreviewController,
		converter: IMarkdownToPdfConverter
	) {
		self.viewController = viewController
		self.converter = converter
	}

	// MARK: - Public Methods

	func present(response: PdfPreviewModel.Response) {

		converter.convert(
			markdownText: response.fileContent,
			author: "",
			title: response.fileUrl.lastPathComponent,
			pageFormat: .a4
		) { [weak self] data in
			let viewModel = PdfPreviewModel.ViewModel(
				currentTitle: response.fileUrl.lastPathComponent,
				data: data
			)

			self?.viewController?.render(viewModel: viewModel)
		}
	}
}
