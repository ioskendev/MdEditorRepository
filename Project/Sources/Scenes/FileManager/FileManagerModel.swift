//
//  FileManagerModel.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/11/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

enum FileManagerModel {

	enum Request {
		case fileSelected(indexPath: IndexPath)
	}

	struct Response {
		let currentFile: File?
		let files: [File]
	}

	struct ViewModel {
		let currentFolderName: String
		let files: [FileModel]

		struct FileModel {
			var name: String
			var info: String
			let isFolder: Bool
		}
	}
}
