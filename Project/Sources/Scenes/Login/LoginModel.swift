//
//  LoginModel.swift
//  MdEditor
//
//  Created by Alexey Turulin on 11/24/23.
//

import Foundation

/// LoginModel является NameSpace для отделения ViewData различных экранов друг отдруга
enum LoginModel {
	struct Request {
		var login: String
		var password: String
	}

	struct Response {
		var result: Result<Void, LoginError>
	}
}
