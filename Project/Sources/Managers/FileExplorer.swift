//
//  FileExplorer.swift
//  MdEditor
//
//  Created by Yuri Volegov on 09.02.2024.
//  Copyright © 2024 ioskendev. All rights reserved.
//

import Foundation

class File {
	var name = ""
	var path = ""
	var ext = ""
	var size: UInt64 = 0
	var isFile = true
	var isDir = false
	var creationDate = Date()
	var modificationDate = Date()
	var fullname: String {
		get {
			return "\(path)/\(name)"
		}
	}

	func getFormattedSize(with size: UInt64) -> String {
		var convertedValue: Double = Double(size)
		var multiplyFactor = 0
		let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
		while convertedValue > 1024 {
			convertedValue /= 1024
			multiplyFactor += 1
		}
		return String(format: "%4.2f %@", convertedValue, tokens[multiplyFactor])
	}

	func getFormattedSize() -> String {
		return getFormattedSize(with: size)
	}

	func getFormattedAttributes() -> String {
		let formattedSize = getFormattedSize()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"

		if isDir {
			return "\(dateFormatter.string(from: modificationDate)) | <dir>"
		} else {
			return "\"\(ext)\" – \(dateFormatter.string(from: modificationDate)) | \(formattedSize)"
		}
	}

	func loadFileBody() -> String {
		var text = ""
		let fullPath = Bundle.main.resourcePath! + "/\(path)/\(name)"
		do {
			text = try String(contentsOfFile: fullPath, encoding: String.Encoding.utf8)
		} catch {
			print("Failed to read text from \(name)")
		}

		return text
	}
}

class FileExplorer {
	var files = [File]()

	func scan(path: String) {
		let fileManager = FileManager.default
		let fullPath = Bundle.main.resourcePath! + "/\(path)"
		files.removeAll()

		var onlyFiles = [File]()
		var onlyFolders = [File]()


		do {
			let items = try fileManager.contentsOfDirectory(atPath: fullPath)
			for item in items {
				if let file = getFile(withNAme: item, atPath: path) {
					if file.isDir {
						onlyFolders.append(file)
					} else {
						onlyFiles.append(file)
					}
				}
			}
		} catch {
			// failed to read directory – bad permissions, perhaps?
		}

		files.append(contentsOf: onlyFolders)
		files.append(contentsOf: onlyFiles)
	}

	func getFile(withNAme name: String, atPath: String) -> File? {
		let fm = FileManager.default
		let fullPath = Bundle.main.resourcePath! + "/\(atPath)"
		do {
			let attr = try fm.attributesOfItem(atPath: fullPath + "/" + name)

			let file = File()
			file.name = name
			file.path = atPath
			file.isDir = (attr[FileAttributeKey.type] as! FileAttributeType) == FileAttributeType.typeDirectory
			file.isFile = (attr[FileAttributeKey.type] as! FileAttributeType) == FileAttributeType.typeRegular
			file.size = (attr[FileAttributeKey.size] as! UInt64)
			file.creationDate = (attr[FileAttributeKey.creationDate] as! Date)
			file.modificationDate = (attr[FileAttributeKey.modificationDate] as! Date)

			if file.isDir {
				file.ext = ""
			} else {
				file.ext = String(describing: name.split(separator: ".").last!)
			}

			return file
		} catch {

		}

		return nil
	}

	static func createFile(withName name: String) -> Bool {
		let fullName = Bundle.main.resourcePath! + "/\(name)"
		let empty = ""
		do {
			try empty.write(toFile: fullName, atomically: false, encoding: .utf8)
			print("Filename created \(fullName)")
			return true
		}
		catch {/* error handling here */
			print("Error, can not create file \(fullName)")
			return false
		}
	}

	static func createFile2(withName name: String) {
		let fullPath = Bundle.main.resourcePath! + "/\(name)"
		let data = "Created on \(Date())".data(using: String.Encoding.utf8)
		let fm = FileManager.default
		fm.createFile(atPath: fullPath, contents: data, attributes: [:])
	}


	/// Создание папки.
	/// - Parameter name: Имя папки.
	static func createFolder(withName name: String) {
		let fullPath = Bundle.main.resourcePath! + "/\(name)"
		let fm = FileManager.default
		do {
			try fm.createDirectory(atPath: fullPath, withIntermediateDirectories: false, attributes: nil)
		} catch let error as NSError {
			print(error.localizedDescription);
		}
	}

}
