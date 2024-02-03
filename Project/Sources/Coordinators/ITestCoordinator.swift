//
//  ITestCoordinator.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/2/24.
//  Copyright © 2024 ioskendev. All rights reserved.
//

protocol ITestCoordinator: AnyObject {
	func testStart(parameters: [LaunchArguments: Bool])
}
