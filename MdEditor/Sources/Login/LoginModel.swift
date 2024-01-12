//
//  LoginModel.swift
//  MdEdit
//
//  Created by Yuri Volegov on 12.01.2024.
//

import Foundation

/// LoginModel it is NameSpace for Login ViewData ond ViewData other screens
enum LoginModel {
	struct Request {
		var login: String
		var password: String
	}

	struct Response {
		var result: Result<Void, LoginError>
	}
}
