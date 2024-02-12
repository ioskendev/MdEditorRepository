//
//  OpenInteractor.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/11/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

protocol IOpenInteractor {
	func fetchData()
	func backButtonPressed()
}

 final class OpenInteractor: IOpenInteractor {

	// MARK: - Dependencies

	private let presenter: IOpenPresenter

	// MARK: - Initialization

	 init(presenter: IOpenPresenter) {
		 self.presenter = presenter
	 }

	// MARK: - Public Methods

	 func fetchData() {
		 let response = OpenModel.Response(files: [])
		 presenter.present(response: response)
	 }

	 func backButtonPressed() {
		 presenter.presentMainScreen()
	 }
 }
