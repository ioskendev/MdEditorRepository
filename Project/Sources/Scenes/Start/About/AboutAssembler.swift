//
//  AboutAssembler.swift
//  MdEditor
//
//  Created by Yuri Volegov on 08.02.2024.
//  Copyright © 2024 ioskendev. All rights reserved.
//

import UIKit

/// Assemble About scene
final class AboutAssembler {

	/// Assemby About scene
	/// - Parameter AboutResultClosure: closure for end scene running
	/// - Returns: AboutViewController
	func assembly() -> AboutViewController {
		let viewController = AboutViewController()
		let presenter = AboutPresenter(viewController: viewController)
		let interactor = AboutInteractor(presenter: presenter)
		viewController.interactor = interactor

		return viewController
	}
}
