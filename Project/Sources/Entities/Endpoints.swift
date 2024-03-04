//
//  Endpoints.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/18/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

// swiftlint:disable force_unwrapping
// swiftlint:disable force_try

enum Endpoints {

	static var documents: URL = {
		try! FileManager.default.url(
			for: .documentDirectory,
			in: .userDomainMask,
			appropriateFor: nil,
			create: true
		)
	}()

	static var examples: URL = {
		Bundle.main.url(forResource: "Examples", withExtension: nil)!
	}()

	static var documentAbout: URL = {
		Bundle.main.url(
			forResource: L10n.aboutFileName,
			withExtension: "md"
		)!
	}()

	static var documentTest: URL = {
		Bundle.main.url(
			forResource: "Examples/test",
			withExtension: "md"
		)!
	}()

	static var documentHeadings: URL = {
		Bundle.main.url(
			forResource: "Examples/Docs/headings",
			withExtension: "md"
		)!
	}()

	static var documentCode: URL = {
		Bundle.main.url(
			forResource: "Examples/Docs/code",
			withExtension: "md"
		)!
	}()

	static var documentEscapingChars: URL = {
		Bundle.main.url(
			forResource: "Examples/Docs/escaping characters",
			withExtension: "md"
		)!
	}()
}

// swiftlint:enable force_try
// swiftlint:enable force_unwrapping
