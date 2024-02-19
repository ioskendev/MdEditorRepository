//
//  FileManagerInteractor.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/11/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

protocol IFileManagerDelegate: AnyObject {
	func openFolder(file: File)
	func openFile(file: File)
}

protocol IFileManagerInteractor {
	func fetchData()
	func performAction(request: FileManagerModel.Request)
}

final class FileManagerInteractor: IFileManagerInteractor {

	// MARK: - Public properties

	weak var delegate: IFileManagerDelegate?

	// MARK: - Dependencies

	private let presenter: IFileManagerPresenter
	private let fileExplorer: IFileExplorer

	// MARK: - Private properties

	private var fileList: FileManagerModel.Response! // swiftlint:disable:this implicitly_unwrapped_optional
	private let currentFile: File?

	// MARK: - Initialization

	init(
		presenter: IFileManagerPresenter,
		fileExplorer: IFileExplorer,
		file: File?
	) {
		self.presenter = presenter
		self.fileExplorer = fileExplorer
		self.currentFile = file
	}

	// MARK: - Public Methods

	func fetchData() {
		if let currentFile {
			switch fileExplorer.contentOfFolder(at: currentFile.url) {
			case .success(let files):
				fileList = FileManagerModel.Response(currentFile: currentFile, files: files)
			case .failure:
				break
			}
		} else {
			var files = [File]()

			if
				let bundleUrl = Bundle.main.url(forResource: "Examples", withExtension: nil),
				case .success(let file) = File.parse(url: bundleUrl) {
				files.append(file)
			}

			if
				let documentsUrl = try? FileManager.default.url(
					for: .documentDirectory,
					in: .userDomainMask,
					appropriateFor: nil,
					create: true
				),
				case .success(let file) = File.parse(url: documentsUrl) {
				files.append(file)
			}
			fileList = FileManagerModel.Response(currentFile: nil, files: files)
		}

		presenter.present(response: fileList)
	}

	func performAction(request: FileManagerModel.Request) {
		switch request {
		case .fileSelected(let indexPath):
			let selectedFile = fileList.files[min(indexPath.row, fileList.files.count - 1)]
			if selectedFile.isFolder {
				delegate?.openFolder(file: selectedFile)
			} else {
				delegate?.openFile(file: selectedFile)
			}
		}
	}
}
