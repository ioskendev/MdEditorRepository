//
//  String+RegularExpression.swift
//
//
//  Created by Alexey Turulin on 2/18/24.
//

import Foundation

extension String {
	func group(for regexPattern: String) -> String? {
		do {
			let text = self
			let regex = try NSRegularExpression(pattern: regexPattern)
			let range = NSRange(location: .zero, length: text.utf16.count)
			
			if let match = regex.firstMatch(in: text, options: [], range: range),
			   let group = Range(match.range(at: 1), in: text) {
				return String(text[group])
			}
		} catch let error {
			print("Invalid regex: \(error.localizedDescription)")
		}
		
		return nil
	}
}
