//
//  AboutPresenter.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/10/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

protocol IAboutPresenter {
	func present(response: AboutModel.Response)
	func presentMainScreen()
}

final class AboutPresenter: IAboutPresenter {

	// MARK: - Dependencies

	private weak var viewController: IAboutViewController?
	private let worker: IMarkdownToHTMLConverter
	private let backClosure: (() -> Void)?

	// MARK: - Initialization

	init(viewController: AboutViewController, worker: IMarkdownToHTMLConverter, backClosure: (() -> Void)?) {
		self.viewController = viewController
		self.worker = worker
		self.backClosure = backClosure
	}

	// MARK: - Public Methods

	func present(response: AboutModel.Response) {
		let html = worker.convert(response.text)
		let viewModel = AboutModel.ViewModel(html: html)

		viewController?.render(viewModel: viewModel)
	}

	func presentMainScreen() {
		backClosure?()
	}
}
