//
//  FileExplorer.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/6/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

enum BundleFiles {
	case about
	case notes

	var name: String {
		switch self {
		case .about:
			return "about.md"
		case .notes:
			return "Notes"
		}
	}

	var path: String {
		switch self {
		case .about:
			return ""
		case .notes:
			return "/Notes"
		}
	}
}

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
	var modificationDate = Date()

	func getFormattedSize() -> String {
		return getFormattedSize(with: size)
	}

	func getFormattedAttributes() -> String {
		let formattedSize = getFormattedSize()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"

		switch type {
		case .file:
			return "\"\(ext)\" – \(dateFormatter.string(from: modificationDate)) | \(formattedSize)"
		case .folder:
			return "\(dateFormatter.string(from: modificationDate)) | <dir>"
		}
	}

	func getImage() -> String {
		switch type {
		case .file:
			return "doc"
		case .folder:
			return "folder"
		}
	}

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

	private func getFormattedSize(with size: UInt64) -> String {
		var convertedValue = Double(size)
		var multiplyFactor = 0
		let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
		while convertedValue > 1024 {
			convertedValue /= 1024
			multiplyFactor += 1
		}
		return String(format: "%4.2f %@", convertedValue, tokens[multiplyFactor])
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

			file.size = (attributes[FileAttributeKey.size] as? UInt64) ?? 0
			file.creationDate = (attributes[FileAttributeKey.creationDate] as? Date) ?? Date()
			file.modificationDate = (attributes[FileAttributeKey.modificationDate] as? Date) ?? Date()

			if attributes[FileAttributeKey.type] as? FileAttributeType == FileAttributeType.typeDirectory {
				file.type = .folder
				file.ext = ""
			} else {
				file.ext = String(describing: name.split(separator: ".").last ?? "")
			}

			return file
		} catch {
		}

		return nil
	}
}
