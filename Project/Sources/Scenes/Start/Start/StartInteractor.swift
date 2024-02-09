//
//  StartInteractor.swift
//  MdEditor
//
//  Created by Maxim Alekseev on 03.02.2024.
//  Copyright © 2024 ioskendev. All rights reserved.
//

import Foundation

protocol IStartInteractor {
	/// Make request to fetch list of recent files
	func fetchRecentFiles()
	func aboutAction()
}

final class StartInteractor: IStartInteractor {

	// MARK: - Dependencies

	private var presenter: IStartPresenter
	private var onAboutPresent: () -> Void

	// MARK: - Initialization

	init(presenter: IStartPresenter, onAboutPresent: @escaping () -> Void) {
		self.presenter = presenter
		self.onAboutPresent = onAboutPresent
	}

	// MARK: - Public methods

	/// Make request to fetch list of recent files
	func fetchRecentFiles() {
		presenter.presentRecentFilesList()
	}

	func aboutAction() {
		onAboutPresent()
	}
}
