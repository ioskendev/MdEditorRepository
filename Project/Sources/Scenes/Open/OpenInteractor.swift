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
	func didFileSelected(request: OpenModel.Request.FileSelected)
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

	 func didFileSelected(request: OpenModel.Request.FileSelected) {
		 let file = fileExplorer.getFile(withName: request.fileName, atPath: BundleFiles.notes.path)
		 if file?.type == .folder {
			 let path = BundleFiles.notes.path + "/" + request.fileName
			 let files = fileExplorer.getFiles(from: path)
			 let response = OpenModel.Response(files: files)
			 presenter.present(response: response)
		 }
	 }
 }

final class Manager {
}
