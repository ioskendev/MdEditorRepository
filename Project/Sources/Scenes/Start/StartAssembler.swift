//
//  StartScreenAssembler.swift
//  MdEditor
//
//  Created by Maxim Alekseev on 03.02.2024.
//  Copyright © 2024 ioskendev. All rights reserved.
//

import Foundation

/// Assemble start scene
final class StartAssembler {

	/// Assembly start scene
	/// - Parameter onFinishPresent: escaping closure () -> Void launch when start screen end presenting
	/// - Returns: StartViewController
	func assembly(onFinishPresent: @escaping () -> Void) -> StartViewController {
		let viewController = StartViewController()
		let presenter = StartPresenter(
			viewController: viewController,
			fileManager: FileManagerStub(),
			onFinishPresent: onFinishPresent
		)
		let interactor = StartInteractor(presenter: presenter)
		viewController.interactor = interactor
		return viewController
	}
}
