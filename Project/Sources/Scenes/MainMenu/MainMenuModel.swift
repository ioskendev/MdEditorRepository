//
//  MainMenuModel.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/5/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

enum MainMenuModel {

	enum MenuIdentifier {
		case openFile
		case newFile
		case showAbout
	}

	enum Request {
		case menuItemSelected(indexPath: IndexPath)
		case recentFileSelected(indexPath: IndexPath)
	}

	struct Response {
		var recentFiles: [RecentFile]
		var menu: [MenuIdentifier]
	}

	struct ViewModel {
		let recentFiles: [RecentFile]
		let menu: [MenuItem]

		struct MenuItem {
			let title: String
			let item: MenuIdentifier
		}

		struct RecentFile {
			let previewText: String
			let fileName: String
		}
	}
}
