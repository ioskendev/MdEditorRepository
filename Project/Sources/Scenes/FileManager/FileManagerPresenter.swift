//
//  FileManagerPresenter.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/11/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

protocol IFileManagerPresenter {
	func present(response: FileManagerModel.Response)
}

final class FileManagerPresenter: IFileManagerPresenter {

	// MARK: - Dependencies

	private weak var viewController: FileManagerViewController?

	// MARK: - Initialization

	init(viewController: FileManagerViewController) {
		self.viewController = viewController
	}

	// MARK: - Public Methods

	func present(response: FileManagerModel.Response) {

		let files: [FileManagerModel.ViewModel.FileModel] = response.files.map {
			FileManagerModel.ViewModel.FileModel(
				name: $0.name,
				info: getFormattedAttributes(file: $0),
				isFolder: $0.isFolder
			)
		}

		let viewModel = FileManagerModel.ViewModel(
			currentFolderName: response.currentFile?.name ?? "/",
			files: files
		)
		viewController?.render(viewModel: viewModel)
	}
}

extension FileManagerPresenter {
	func getFormattedAttributes(file: File) -> String {
		let formattedSize = getFormatted(size: file.size)
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"

		if file.isFolder {
			return "\(dateFormatter.string(from: file.modificationDate)) | <dir>"
		} else {
			return "\"\(file.ext)\" – \(dateFormatter.string(from: file.modificationDate)) | \(formattedSize)"
		}
	}

	private func getFormatted(size: UInt64) -> String {
		var convertedValue = Double(size)
		var multiplyFactor = 0
		let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
		while convertedValue > 1024 {
			convertedValue /= 1024
			multiplyFactor += 1
		}
		return String(format: "%4.2f %@", convertedValue, tokens[multiplyFactor])
	}
}
