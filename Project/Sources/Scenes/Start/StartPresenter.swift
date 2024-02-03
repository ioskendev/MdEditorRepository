//
//  StartPresenter.swift
//  MdEditor
//
//  Created by Maxim Alekseev on 03.02.2024.
//  Copyright © 2024 ioskendev. All rights reserved.
//

import Foundation

/// Start screen Presentation logic protocol
protocol IStartPresenter { 
	/// Perform request for present recent files list
	func presentRecentFilesList()
}

/// Start screen Interactor logic
final class StartPresenter: IStartPresenter {

	// MARK: - Dependencies

	private weak var viewController: IStartViewController! // swiftlint:disable:this implicitly_unwrapped_optional
	private let fileManager: IFileManager
	private let onFinishPresent: () -> Void

	// MARK: - Initialization

	init(
		viewController: IStartViewController,
		fileManager: IFileManager,
		onFinishPresent: @escaping () -> Void
	) {
		self.viewController = viewController
		self.onFinishPresent = onFinishPresent
		self.fileManager = fileManager
	}

	// MARK: - Public methods

	func presentRecentFilesList() {
		viewController.render(viewModel: StartModel.ViewModel(recentFiles: fileManager.getRecentFiles()))
	}
}
