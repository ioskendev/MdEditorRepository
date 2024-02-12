//
//  OpenInteractor.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/11/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

protocol IOpenInteractor {
	func fetchData()
	func backButtonPressed()
}

 final class OpenInteractor: IOpenInteractor {

	// MARK: - Dependencies

	private let presenter: IOpenPresenter
	 private let fileExplorer: IFileExplorer

	// MARK: - Initialization

	 init(presenter: IOpenPresenter, fileExplorer: IFileExplorer) {
		 self.presenter = presenter
		 self.fileExplorer = fileExplorer
	 }

	// MARK: - Public Methods

	 func fetchData() {
		 let files = fileExplorer.getFiles(from: BundleFiles.notes.path)
		 let response = OpenModel.Response(files: files)
		 presenter.present(response: response)
	 }

	 func backButtonPressed() {
		 presenter.presentMainScreen()
	 }
 }
