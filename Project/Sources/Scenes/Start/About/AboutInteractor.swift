//
//  AboutViewController.swift
//  MdEditor
//
//  Created by ioskendev on 25.12.2023.
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

	/// About func realisation with request model
	/// - Parameter request: AboutModel.Request
	func show() {

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

	enum Types { // stub for types in file manager
		static var md = "md"
	}
}
