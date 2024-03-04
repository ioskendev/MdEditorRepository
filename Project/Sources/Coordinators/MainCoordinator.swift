//
//  MainMenuCoordinator.swift
//  MdEdit
//
//  Created by ioskendev on 12.01.2024.
//

import UIKit
import MarkdownPackage

final class MainCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private let recentFileManager = StubRecentFileManager()
	private let converter = MarkdownToAttributedStringConverter()

	// MARK: - Initialization

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Internal methods

	override func start() {
		showMainMenuScene()
	}
}

// MARK: - Private methods

private extension MainCoordinator {

	func showMainMenuScene() {
		let assembler = MainMenuAssembler(recentFileManager: recentFileManager)
		let (viewController, interactor) = assembler.assembly()
		viewController.navigationItem.setHidesBackButton(true, animated: true)
		interactor.delegate = self

		navigationController.pushViewController(viewController, animated: true)
	}

	func showTextPreviewScene(file: File) {
		let assembler = TextPreviewAssembler(
			file: file,
			converter: converter
		)
		let viewController = assembler.assembly()

		navigationController.pushViewController(viewController, animated: true)
	}

	func runFileManagerFlow() {
		let topViewController = navigationController.topViewController
		let coordinator = FileManagerCoordinator(
			navigationController: navigationController,
			topViewController: topViewController,
			converter: converter
		)
		addDependency(coordinator)

		coordinator.finishFlow = { [weak self, weak coordinator] in
			guard let self = self else { return }
			if let topViewController = topViewController {
				self.navigationController.popToViewController(topViewController, animated: true)
			} else {
				self.navigationController.popToRootViewController(animated: true)
			}
			if let coordinator = coordinator {
				self.removeDependency(coordinator)
			}
		}

		coordinator.start()
	}
}

// MARK: - IMainMenuDelegate

extension MainCoordinator: IMainMenuDelegate {

	func showAbout() {
		let aboutUrl = Bundle.main.url(
			forResource: L10n.aboutFileName,
			withExtension: "md"
		)! // swiftlint:disable:this force_unwrapping
		switch File.parse(url: aboutUrl) {
		case .success(let aboutFile):
			showTextPreviewScene(file: aboutFile)
		case .failure:
			break
		}
	}

	func openFileExplorer() {
		runFileManagerFlow()
	}

	func openFile(file: File) {
		showTextPreviewScene(file: file)
	}

	func newFile() {}
}
