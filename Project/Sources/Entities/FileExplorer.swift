//
//  FileExplorer.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/6/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

/// A protocol defining the interface for file explorer service.
protocol IFileExplorer {

	/// Retrieves the content of a folder at a specified URL.
	/// - Parameter url: The URL of the folder to explore.
	/// - Returns: A result containing an array of 'File' objects or an error.
	func contentOfFolder(at url: URL) -> Result<[File], Error>

	/// Creates a new folder at a specified URL with the given name.
	/// - Parameters:
	///   - url: The URL where the URL will be created.
	///   - name: The name of the folder to create.
	/// - Returns: A result containing the created 'File' object representing the folder or an error.
	func createFolder(at url: URL, withName name: String) -> Result<File, Error>

	/// Creates a new file at a specified URL with the given file name.
	/// - Parameters:
	///   - url: The URL where the file will be created.
	///   - fileName: The name of the file to create.
	/// - Returns: A result containing the created 'File' object or an error.
	func createNewFile(at url: URL, fileName: String) -> Result<File, Error>
}

/// An implementation of the 'IFileExplorer' protocol using FileManager.
final class FileExplorer: IFileExplorer {

	// MARK: - Dependencies

	private let fileManager = FileManager.default

	// MARK: - Private Properties

	private let fileEncoding = String.Encoding.utf8

	// MARK: - Public Methods

	/// Retrieves the content of a folder at a specified URL.
	/// - Parameter url: The URL of the folder to explore.
	/// - Returns: A result containing an array of 'File' objects or an error.
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

	/// Creates a new folder at a specified URL with the given name.
	/// - Parameters:
	///   - url: The URL where the URL will be created.
	///   - name: The name of the folder to create.
	/// - Returns: A result containing the created 'File' object representing the folder or an error.
	func createFolder(at url: URL, withName name: String) -> Result<File, Error> {
		do {
			let newFolderUrl = url.appendingPathComponent("\(name)")
			try fileManager.createDirectory(at: newFolderUrl, withIntermediateDirectories: true)
			return File.parse(url: newFolderUrl)
		} catch {
			return .failure(error)
		}
	}

	/// Creates a new file at a specified URL with the given file name.
	/// - Parameters:
	///   - url: The URL where the file will be created.
	///   - fileName: The name of the file to create.
	/// - Returns: A result containing the created 'File' object or an error.
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
