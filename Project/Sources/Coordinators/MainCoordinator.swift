//
//  TodoListCoordinator.swift
//  MdEdit
//
//  Created by ioskendev on 12.01.2024.
//

import UIKit
import TaskManagerPackage

final class MainCoordinator: ICoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private let fileExplorer: IFileExplorer

	// MARK: - Internal properties

	var finishFlow: ((NextScreen) -> Void)?

	// MARK: - Initialization

	init(navigationController: UINavigationController, fileExplorer: IFileExplorer) {
		self.navigationController = navigationController
		self.fileExplorer = fileExplorer
	}

	// MARK: - Internal methods

	func start() {
		showMainScene()
	}

	func showMainScene() {
		let assembler = MainAssembler(fileExplorer: fileExplorer)
		let viewController = assembler.assembly { [weak self] nextScreen in
			self?.finishFlow?(nextScreen)
		}
		navigationController.pushViewController(viewController, animated: true)
	}
}
