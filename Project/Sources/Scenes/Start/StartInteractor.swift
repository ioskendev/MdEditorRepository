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
}

final class StartInteractor: IStartInteractor {

	// MARK: - Dependencies

	private var presenter: IStartPresenter

	// MARK: - Initialization

	init(presenter: IStartPresenter) {
		self.presenter = presenter
	}

	// MARK: - Public methods

	/// Make request to fetch list of recent files
	func fetchRecentFiles() {
		presenter.presentRecentFilesList()
	}
}
