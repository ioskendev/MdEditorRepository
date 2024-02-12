//
//  OpenAssembler.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/11/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit

final class OpenAssembler {
	func assemble(backClosure: (() -> Void)?) -> OpenViewController {
		let viewController = OpenViewController()
		let presenter: IOpenPresenter = OpenPresenter(
			viewController: viewController,
			backClosure: backClosure
		)
		let interactor: IOpenInteractor = OpenInteractor(presenter: presenter)
		viewController.interactor = interactor

		return viewController
	}
}
