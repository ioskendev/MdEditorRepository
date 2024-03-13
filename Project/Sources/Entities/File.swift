//
//  File.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/16/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

/// Represents a file or directory within the file system.
struct File {

	/// The URL of the file or directory.
	let url: URL

	/// A Boolean value indicating whether the URL is a directory.
	let isFolder: Bool

	/// The size of the file in bytes.
	let size: UInt64

	/// The creation date of the file or directory.
	let creationDate: Date

	/// The last modification date of the file or directory.
	let modificationDate: Date

	private init(url: URL, isFolder: Bool, size: UInt64, creationDate: Date, modificationDate: Date) {
		self.url = url
		self.isFolder = isFolder
		self.size = size
		self.creationDate = creationDate
		self.modificationDate = modificationDate
	}

	/// Errors that can occur when parsing a file's attributes.
	enum ParseError: Error {
		case wrongAttribute
	}

	/// Parses the attributes of a file or directory from its URL.
	/// - Parameter url: The URL of the file or directory.
	/// - Returns: A result containing a File instance or an error.
	static func parse(url: URL) -> Result<File, Error> {
		let fileManager = FileManager.default
		do {
			let attributes = try fileManager.attributesOfItem(atPath: url.relativePath)
			if
				let type = attributes[.type] as? FileAttributeType,
				let size = attributes[.size] as? UInt64,
				let creationDate = attributes[.creationDate] as? Date,
				let modoficationDate = attributes[.modificationDate] as? Date
			{
				let file = File(
					url: url,
					isFolder: type == .typeDirectory,
					size: size,
					creationDate: creationDate,
					modificationDate: modoficationDate
				)
				return .success(file)
			} else {
				return .failure(ParseError.wrongAttribute)
			}
		} catch {
			return .failure(error)
		}
	}

	/// The full name of the file or directory.
	var fullName: String {
		url.absoluteString
	}

	/// The path of the file or directory, excluding the file name.
	var path: String {
		url.deletingLastPathComponent().absoluteString
	}

	/// The name of the file or directory, excluding the path.
	var name: String {
		url.lastPathComponent
	}

	/// The file extension of the file, if any.
	var ext: String {
		url.pathExtension
	}

	/// Reads the content of the file.
	/// - Returns: The content of the file as Data, or nil if reading fails.
	func contentOfFile() -> Data? {
		try? Data(contentsOf: url)
	}
}
