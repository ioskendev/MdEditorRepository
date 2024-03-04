//
//  LaunchArguments.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/2/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

enum LaunchArguments: String {
	case enableTesting = "-enableTesting"
	case runTodoListFlow = "-runTodoListFlow"
	case runMainFlow = "-runMainFlow"

	static func parameters() -> [LaunchArguments: Bool] {
		var parameters = [LaunchArguments: Bool]()

		for argument in CommandLine.arguments {
			if let parameter = LaunchArguments(rawValue: argument) {
				parameters[parameter] = true
			}
		}

		return parameters
	}
}
