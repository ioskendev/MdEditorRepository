//
//  MainMenuInteractor.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/5/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

protocol IMainMenuDelegate: AnyObject {
	func showAbout()
	func openFileExplorer()
	func openFile(file: File)
	func newFile()
}

protocol IMainMenuInteractor {
	func fetchData()
	func performAction(request: MainMenuModel.Request)
}

final class MainMenuInteractor: IMainMenuInteractor {

	// MARK: - Public properties

	weak var delegate: IMainMenuDelegate?

	// MARK: - Dependencies

	private let presenter: IMainMenuPresenter
	private let recentFileManager: IRecentFileManager

	// MARK: - Private properties

	private let menu: [MainMenuModel.MenuIdentifier] = [
		.newFile,
		.openFile,
		.showAbout
	]

	// MARK: - Initialization

	init(
		presenter: IMainMenuPresenter,
		recentFileManager: IRecentFileManager
	) {
		self.presenter = presenter
		self.recentFileManager = recentFileManager
	}

	// MARK: - Public Methods

	func fetchData() {
		let recentFiles = recentFileManager.getRecentFiles()
		let response = MainMenuModel.Response(recentFiles: recentFiles, menu: menu)
		presenter.present(response: response)
	}

	func performAction(request: MainMenuModel.Request) {
		switch request {
		case .menuItemSelected(let indexPath):
			let selectedMenuItem = menu[min(indexPath.row, menu.count - 1)]
			switch selectedMenuItem {
			case .openFile:
				delegate?.openFileExplorer()
			case .newFile:
				delegate?.newFile()
			case .showAbout:
				delegate?.showAbout()
			}
		case .recentFileSelected(let indexPath):
			let recentFiles = recentFileManager.getRecentFiles()
			let recentFile = recentFiles[min(indexPath.row, recentFiles.count - 1)]
			if case .success(let file) = File.parse(url: recentFile.url) {
				delegate?.openFile(file: file)
			}
		}
	}
}
