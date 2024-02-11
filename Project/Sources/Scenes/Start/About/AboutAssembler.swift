//
//  AboutViewController.swift
//  MdEditor
//
//  Created by ioskendev on 25.12.2023.
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
