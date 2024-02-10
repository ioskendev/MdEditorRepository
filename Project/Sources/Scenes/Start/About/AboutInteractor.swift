//
//  AboutInteractor.swift
//  MdEditor
//
//  Created by Yuri Volegov on 08.02.2024.
//  Copyright © 2024 ioskendev. All rights reserved.
//

import Foundation

protocol IAboutInteractor {
	func show()
}

final class AboutInteractor: IAboutInteractor {

	// MARK: - Dependencies

	private var presenter: IAboutPresenter?

	// MARK: - Initialization

	init(presenter: IAboutPresenter) {
		self.presenter = presenter
	}

	// MARK: - Public methods

	/// login func realisation with request model
	/// - Parameter request: LoginModel.Request
	func show() { // Users/volegov/Developer/Next_aboutWindow/MdEditorRepository/Project/Resources/Book_of_knowledge

		if let filepath = Bundle.main.path(forResource: "Book_of_knowledge/README", ofType: Types.md) {
			do {
				let contents = try String(contentsOfFile: filepath)
				presenter?.present(responce: AboutModel.Response(aboutText: contents))
			} catch {
				print("contents could not be loaded \(error)")
			}
		} else {
			print("file not found")
		}
	}

	enum Types {
		static var md = "md"
	}
}
