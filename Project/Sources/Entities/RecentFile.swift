//
//  RecentFile.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/17/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

/// Represents a recently accessed or modified file, providing quick access information.
struct RecentFile {

	/// A brief preview text.
	let previewText: String

	/// The URL of the recent file.
	let url: URL

	/// The creation date of the recent file.
	let createDate: Date
}
