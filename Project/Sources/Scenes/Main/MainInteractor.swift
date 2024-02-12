//
//  MainInteractor.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/5/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

protocol IMainInteractor {
	func fetchData()
	func buttonAboutPressed()
	func buttonOpenPressed()
}

final class MainInteractor: IMainInteractor {

	// MARK: - Dependencies

	private let presenter: IMainPresenter
	private let fileExplorer: IFileExplorer

	// MARK: - Initialization

	init(presenter: IMainPresenter, fileExplorer: IFileExplorer) {
		self.presenter = presenter
		self.fileExplorer = fileExplorer
	}

	// MARK: - Public Methods

	func fetchData() {
		var response = MainModel.Response(files: [])

		let files = fileExplorer.getFiles(from: BundleFiles.notes.path)
		response.files = files

		presenter.present(response: response)
	}

	func buttonAboutPressed() {
		presenter.presentAboutScreen()
	}

	func buttonOpenPressed() {
		presenter.presentOpenScreen()
	}
}
