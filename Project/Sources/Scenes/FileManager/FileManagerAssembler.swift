//
//  FileManagerAssembler.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/11/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit

final class FileManagerAssembler {

	// MARK: - Dependencies

	private let fileExplorer: IFileExplorer
	private let file: File?

	// MARK: - Initializers

	init(fileExplorer: IFileExplorer, file: File?) {
		self.fileExplorer = fileExplorer
		self.file = file
	}

	// MARK: - Public methods

	func assembly() -> (FileManagerViewController, FileManagerInteractor) {
		let viewController = FileManagerViewController()
		let presenter = FileManagerPresenter(
			viewController: viewController
		)
		let interactor = FileManagerInteractor(
			presenter: presenter,
			fileExplorer: fileExplorer,
			file: file
		)
		viewController.interactor = interactor
		return (viewController, interactor)
	}
}
