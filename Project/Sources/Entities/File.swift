//
//  File.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/16/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

struct File {
	let url: URL
	let isFolder: Bool
	let size: UInt64
	let creationDate: Date
	let modificationDate: Date

	private init(url: URL, isFolder: Bool, size: UInt64, creationDate: Date, modificationDate: Date) {
		self.url = url
		self.isFolder = isFolder
		self.size = size
		self.creationDate = creationDate
		self.modificationDate = modificationDate
	}

	enum ParseError: Error {
		case wrongAttribute
	}

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

	var fullName: String {
		url.absoluteString
	}

	var path: String {
		url.deletingLastPathComponent().absoluteString
	}

	var name: String {
		url.lastPathComponent
	}

	var ext: String {
		url.pathExtension
	}

	func contentOfFile() -> Data? {
		try? Data(contentsOf: url)
	}
}
