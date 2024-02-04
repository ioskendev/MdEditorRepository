//
//  FileManager.swift
//  MdEditor
//
//  Created by Maxim Alekseev on 03.02.2024.
//  Copyright © 2024 ioskendev. All rights reserved.
//

import Foundation

enum FileContentType {
	case usual
	case richText
}

protocol IRecentFile {
	var name: String { get }
	var contentType: FileContentType { get }
}

struct RecentFile: IRecentFile {
	let name: String
	let contentType: FileContentType
}

/// Protocol of file manager
protocol IFileManager {
	/// Get array of recent files
	func getRecentFiles() -> [IRecentFile]
}

/// Stub of file manager
final class FileManagerStub: IFileManager {
	func getRecentFiles() -> [IRecentFile] {
		return [
			RecentFile(name: "about.md", contentType: FileContentType.usual),
			RecentFile(name: "ascii.md", contentType: FileContentType.usual),
			RecentFile(name: "rpn.md", contentType: FileContentType.richText),
			RecentFile(name: "swift.md", contentType: FileContentType.richText),
			RecentFile(name: "utm.md", contentType: FileContentType.richText)
		]
	}
}
