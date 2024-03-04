//
//  NSRegularExpression+Match.swift
//
//
//  Created by Alexey Turulin on 3/1/24.
//

import Foundation

extension NSRegularExpression {
	func match(_ text: String) -> Bool {
		let range = NSRange(text.startIndex..., in: text)
		return firstMatch(in: text, range: range) != nil
	}
}
