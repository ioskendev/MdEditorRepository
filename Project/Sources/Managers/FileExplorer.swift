//
//  FileExplorer.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/6/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

struct File {

	enum FileType {
		case file
		case folder
	}

	var name = ""
	var path = ""
	var ext = ""
	var type: FileType
	var size: UInt64 = 0
	var creationDate = Date()

	func loadFileBody() -> String {
		var text = ""
		let fullPath = Bundle.main.resourcePath! + "\(path)/\(name)" // swiftlint:disable:this force_unwrapping

		do {
			text = try String(contentsOfFile: fullPath, encoding: .utf8)
		} catch {
			print("Failed to read text from \(name)") // swiftlint:disable:this print_using
		}

		return text
	}
}

protocol IFileExplorer {
	init(fileManager: FileManager)
	func getFiles(from path: String) -> [File]
	func getFile(withName name: String, atPath path: String) -> File?
}

final class FileExplorer: IFileExplorer {

	// MARK: - Dependencies

	private let fileManager: FileManager

	// MARK: - Private Properties

	private var files: [File] = []

	// MARK: - Initialization

	init(fileManager: FileManager) {
		self.fileManager = fileManager
	}

	// MARK: - Public Methods

	func getFiles(from path: String) -> [File] {
		scan(path: path)
		return files
	}

	// MARK: - Private methods

	func scan(path: String) {
		let fullPath = Bundle.main.resourcePath! + "\(path)" // swiftlint:disable:this force_unwrapping
		files.removeAll()

		var onlyFiles = [File]()
		var onlyFolders = [File]()

		do {
			let items = try fileManager.contentsOfDirectory(atPath: fullPath)

			for item in items {
				if let file = getFile(withName: item, atPath: path) {
					switch file.type {
					case .file:
						onlyFiles.append(file)
					case .folder:
						onlyFolders.append(file)
					}
				}
			}
		} catch {
		}

		files.append(contentsOf: onlyFolders)
		files.append(contentsOf: onlyFiles)
	}

	func getFile(withName name: String, atPath path: String) -> File? {
		let fullPath = Bundle.main.resourcePath! + "\(path)" // swiftlint:disable:this force_unwrapping

		do {
			let attributes = try fileManager.attributesOfItem(atPath: fullPath + "/" + name)

			var file = File(type: .file)
			file.name = name
			file.path = path

			if attributes[FileAttributeKey.type] as? FileAttributeType == FileAttributeType.typeDirectory {
				file.type = .folder
			}

			return file
		} catch {
		}

		return nil
	}
}
