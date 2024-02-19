//
//  FileManagerCoordinator.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/11/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit

protocol IFileManagerCoordinator: ICoordinator {
	var finishFlow: (() -> Void)? { get set }
}

final class FileManagerCoordinator: NSObject, IFileManagerCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private var topViewController: UIViewController?

	private let fileExplorer: IFileExplorer

	// MARK: - Internal properties

	var finishFlow: (() -> Void)?

	// MARK: - Initialization

	init(
		navigationController: UINavigationController,
		topViewController: UIViewController?,
		fileExplorer: IFileExplorer
	) {
		self.navigationController = navigationController
		self.topViewController = topViewController
		self.fileExplorer = fileExplorer

		super.init()

		navigationController.delegate = self
	}

	// MARK: - Internal methods

	func start() {
		showFileManagerScene(file: nil)
	}
}

// MARK: - Private methods

private extension FileManagerCoordinator {

	func showFileManagerScene(file: File?) {
		let assembler = FileManagerAssembler(
			fileExplorer: fileExplorer,
			file: file
		)
		let (viewController, interactor) = assembler.assembly()
		interactor.delegate = self

		navigationController.pushViewController(viewController, animated: true)
	}

	func showTextPreviewScene(file: File) {
		let assembler = TextPreviewAssembler(file: file)
		let viewController = assembler.assembly()

		navigationController.pushViewController(viewController, animated: true)
	}
}

// MARK: - UINavigationControllerDelegate

extension FileManagerCoordinator: UINavigationControllerDelegate {

	func navigationController(
		_ navigationController: UINavigationController,
		didShow viewController: UIViewController,
		animated: Bool
	) {
		if viewController === topViewController {
			finishFlow?()
		}
	}
}

// MARK: - IFileManagerDelegate

extension FileManagerCoordinator: IFileManagerDelegate {
	func openFolder(file: File) {
		showFileManagerScene(file: file)
	}

	func openFile(file: File) {
		showTextPreviewScene(file: file)
	}
}
