//
//  AboutCoordinator.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/10/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit

final class AboutCoordinator: ICoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private let fileExplorer: IFileExplorer
	private let converter: IMarkdownToHTMLConverter

	// MARK: - Internal properties

	var finishFlow: (() -> Void)?

	// MARK: - Initialization

	init(navigationController: UINavigationController, fileExplorer: IFileExplorer, converter: IMarkdownToHTMLConverter) {
		self.navigationController = navigationController
		self.fileExplorer = fileExplorer
		self.converter = converter
	}

	// MARK: - Internal methods

	func start() {
		showAboutScene()
	}

	func showAboutScene() {
		let assembler = AboutAssembler(fileExplorer: fileExplorer, converter: converter)
		let viewController = assembler.assembly { [weak self] in
			self?.finishFlow?()
		}
		navigationController.pushViewController(viewController, animated: true)
	}
}
