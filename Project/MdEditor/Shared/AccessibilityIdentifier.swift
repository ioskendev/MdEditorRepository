//
//  AccessibilityIdentifier.swift
//  MdEditor
//
//  Created by Alexey Turulin on 1/16/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

enum AccessibilityIdentifier {
	case textFieldLogin
	case textFieldPass
	case buttonLogin

	case section(index: Int)
	case cell(section: Int, row: Int)

	var description: String {
		switch self {
		case .textFieldLogin:
			return "textFieldLogin"
		case .textFieldPass:
			return "textFieldPass"
		case .buttonLogin:
			return "buttonLogin"
		case .section(index: let index):
			return "section-\(index)"
		case .cell(section: let section, row: let index):
			return "cell-\(section)-\(index)"
		}
	}
}
