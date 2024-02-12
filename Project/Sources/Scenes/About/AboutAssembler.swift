//
//  AboutAssembler.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/10/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit

final class AboutAssembler {

	// MARK: - Dependencies

	private let fileExplorer: IFileExplorer
	private let converter: IMarkdownToHTMLConverter

	// MARK: - Initializers

	init(fileExplorer: IFileExplorer, converter: IMarkdownToHTMLConverter) {
		self.fileExplorer = fileExplorer
		self.converter = converter
	}

	// MARK: - Public methods

	func assembly(backClosure: (() -> Void)?) -> AboutViewController {
		let viewController = AboutViewController()
		let presenter: IAboutPresenter = AboutPresenter(
			viewController: viewController,
			worker: converter,
			backClosure: backClosure
		)
		let interactor: IAboutInteractor = AboutInteractor(presenter: presenter, fileExplorer: fileExplorer)

		viewController.interactor = interactor

		return viewController
	}
}
