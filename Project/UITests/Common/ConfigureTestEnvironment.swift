//
//  ConfigureTestEnvironment.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/2/24.
//  Copyright © 2024 ioskendev. All rights reserved.
//

enum ConfigureTestEnvironment {

	static let lang = ["-AppLanguages", "(en)"]

	enum InvalidCredentials {
		static let  login = "pa$$32!"
		static let password = "Admin"
	}

	enum ValidCredentials {
		static let login = "Admin"
		static let password = "pa$$32!"
	}
}
