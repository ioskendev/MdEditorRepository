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
		if let filePath = Bundle.main.path(forResource: "README", ofType: "md", inDirectory: "Resources/Book_of_knowledge/") {
				do {
					let content = try String(contentsOfFile: filePath, encoding: .utf8)
					let response = AboutModel.Response(aboutText: content)
					presenter?.present(responce: AboutModel.Response(aboutText: response.aboutText))
				} catch {
					print("Ошибка при чтении файла: \(error)")
				}
			} else {
				print("Файл README.md не найден")
			}
	}
}
