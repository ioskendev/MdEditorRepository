//
//  TaskPriority+CustomStringConvertible.swift
//  MdEditor
//
//  Created by Alexey Turulin on 1/14/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation
import TaskManagerPackage

extension ImportantTask.TaskPriority: CustomStringConvertible {
	public var description: String {
		switch self {
		case .high:
			return "!!!"
		case .medium:
			return "!!"
		case .low:
			return "!"
		}
	}
}
