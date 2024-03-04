//
//  TextPreviewModel.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/10/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

enum TextPreviewModel {
	struct Response {
		let fileUrl: URL
		let fileContent: String
	}

	struct ViewModel {
		let currentTitle: String
		let text: NSMutableAttributedString
	}
}
