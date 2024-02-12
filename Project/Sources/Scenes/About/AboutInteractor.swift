//
//  AboutInteractor.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/10/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

protocol IAboutInteractor {
	func fetchData()
	func backButtonPressed()
}

final class AboutInteractor: IAboutInteractor {

	// MARK: - Dependencies

	private let presenter: IAboutPresenter
	private let fileExplorer: IFileExplorer

	// MARK: - Initialization

	init(presenter: IAboutPresenter, fileExplorer: IFileExplorer) {
		self.presenter = presenter
		self.fileExplorer = fileExplorer
	}

	// MARK: - Public Methods

	func fetchData() {
		var response = AboutModel.Response(text: "")

		if let file = fileExplorer.getFile(withName: BundleFiles.about.name, atPath: BundleFiles.about.path) {
			let text = file.loadFileBody()
			response.text = text
		}

		presenter.present(response: response)
	}

	func backButtonPressed() {
		presenter.presentMainScreen()
	}
}
