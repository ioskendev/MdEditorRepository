//
//  OpenModel.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/11/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

enum OpenModel {

	struct Response {
		let files: [File]
	}

	struct ViewModel {
		let files: [File]

		struct File {
			let name: String
		}
	}
}
