//
//  RecentFileManager.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/18/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

protocol IRecentFileManager {
	func getRecentFiles() -> [RecentFile]
}

final class RecentFileManager: IRecentFileManager {
	func getRecentFiles() -> [RecentFile] {
		return []
	}
}

final class StubRecentFileManager: IRecentFileManager {
	func getRecentFiles() -> [RecentFile] {
		return [
			RecentFile(
				previewText: "# О приложении",
				url: Endpoints.documentAbout,
				createDate: Date()
			),

			RecentFile(
				previewText: "# Как работать в Markdown с Заголовками",
				url: Endpoints.documentHeadings,
				createDate: Date()
			),

			RecentFile(
				previewText: "# Вставка кода (code)",
				url: Endpoints.documentCode,
				createDate: Date()
			),

			RecentFile(
				previewText: "# Экранирование (escaping characters)",
				url: Endpoints.documentEscapingChars,
				createDate: Date()
			)
		]
	}
}
