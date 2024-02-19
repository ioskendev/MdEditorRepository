//
//  FileExplorer.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/6/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

protocol IFileExplorer {
	func contentOfFolder(at url: URL) -> Result<[File], Error>
	func createFolder(at url: URL, withName name: String) -> Result<File, Error>
	func createNewFile(at url: URL, fileName: String) -> Result<File, Error>
}

final class FileExplorer: IFileExplorer {

	// MARK: - Dependencies

	private let fileManager = FileManager.default

	// MARK: - Private Properties

	private let fileEncoding = String.Encoding.utf8

	// MARK: - Public Methods

	func contentOfFolder(at url: URL) -> Result<[File], Error> {
		var files = [File]()

		do {
			let fileNames = try fileManager.contentsOfDirectory(atPath: url.relativePath)
			for fileName in fileNames {
				let file = File.parse(url: url.appendingPathComponent("\(fileName)"))
				switch file {
				case .success(let file):
					files.append(file)
				case .failure(let error):
					return .failure(error)
				}
			}
			return .success(files)
		} catch {
			return .failure(error)
		}
	}

	func createFolder(at url: URL, withName name: String) -> Result<File, Error> {
		do {
			let newFolderUrl = url.appendingPathComponent("\(name)")
			try fileManager.createDirectory(at: newFolderUrl, withIntermediateDirectories: true)
			return File.parse(url: newFolderUrl)
		} catch {
			return .failure(error)
		}
	}

	func createNewFile(at url: URL, fileName: String) -> Result<File, Error> {
		do {
			let newFileUrl = url.appendingPathComponent("\(fileName)")
			try "".write(to: newFileUrl, atomically: true, encoding: fileEncoding)
			return File.parse(url: newFileUrl)
		} catch {
			return .failure(error)
		}
	}
}
