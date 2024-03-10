//
//  AccessibilityIdentifier.swift
//  MdEditor
//
//  Created by Alexey Turulin on 1/16/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

enum AccessibilityIdentifier {

	enum LoginScene: CustomStringConvertible {
		case textFieldLogin
		case textFieldPass
		case buttonLogin

		var description: String {
			switch self {
			case .textFieldLogin:
				return "loginScene.textFieldLogin"
			case .textFieldPass:
				return "loginScene.textFieldPass"
			case .buttonLogin:
				return "loginScene.buttonLogin"
			}
		}
	}
	enum MainMenuScene: CustomStringConvertible {
		case recentFiles
		case menu

		var description: String {
			switch self {
			case .recentFiles:
				return "mainMenuScene.recentFIles"
			case .menu:
				return "mainMenuScene.menu"
			}
		}
	}

	enum FileManagerScene: CustomStringConvertible {
		case menu

		var description: String {
			switch self {
			case .menu:
				return "fileManagerScene.menu"
			}
		}
	}

	enum TextPreviewScene: CustomStringConvertible {
		case textView
		case barButton

		var description: String {
			switch self {
			case .textView:
				return "textPreviewScene.textView"
			case .barButton:
				return "textPreviewScene.barButton"
			}
		}
	}

	enum PdfPreviewScene: CustomStringConvertible {
		case pdfView
		case barButton

		var description: String {
			switch self {
			case .pdfView:
				return "pdfPreviewScene.pdfView"
			case .barButton:
				return "pdfPreviewScene.barButton"
			}
		}
	}

	enum TodoListScene: CustomStringConvertible {
		case table
		case section(Int)
		case cell(section: Int, row: Int)

		var description: String {
			switch self {
			case .table:
				return "todoListScene.table"
			case .section(let index):
				return "todoListScene.section-\(index)"
			case .cell(section: let section, row: let row):
				return "todoListScene.cell-\(section)-\(row)"
			}
		}
	}
}
