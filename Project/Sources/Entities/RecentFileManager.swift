//
//  RecentFileManager.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/18/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

/// A protocol definong the interface for managing and retrieving recent files.
protocol IRecentFileManager {

	/// Retrieves a list of recent files accessed or modified.
	/// - Returns: An array of 'RecentFile' instances, representing the recent files.
	func getRecentFiles() -> [RecentFile]
}

/// Manages the retrieval of recent files.
final class RecentFileManager: IRecentFileManager {

	/// Retrieves a list of recent files accessed or modified.
	/// - Returns: An array of 'RecentFile' instances, representing the recent files.
	func getRecentFiles() -> [RecentFile] {
		return []
	}
}

/// Provides a stubbed implementation of the 'IRecentFileManager' for testing or demonstartion purposes.
final class StubRecentFileManager: IRecentFileManager {

	/// Returns a predefined set of 'RecentFile' instances.
	/// - Returns: An array of 'RecentFile' instances.
	func getRecentFiles() -> [RecentFile] {
		return [
			RecentFile(
				previewText: "# Markdown Test",
				url: Endpoints.documentTest,
				createDate: Date()
			),

			RecentFile(
				previewText: "# Markdown Headers.",
				url: Endpoints.documentHeadings,
				createDate: Date()
			),

			RecentFile(
				previewText: "# Code.",
				url: Endpoints.documentCode,
				createDate: Date()
			),

			RecentFile(
				previewText: "# Escaping characters",
				url: Endpoints.documentEscapingChars,
				createDate: Date()
			)
		]
	}
}
