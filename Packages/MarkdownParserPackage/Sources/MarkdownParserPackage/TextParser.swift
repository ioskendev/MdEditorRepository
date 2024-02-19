//
//  TextParser.swift
//
//
//  Created by Alexey Turulin on 2/14/24.
//

import Foundation

public protocol ITextParser {
	func parse(rawtext text: String) -> Text
}

public final class TextParser: ITextParser {
	private struct PartRegExp {
		let type: PartType
		let regex: NSRegularExpression
		
		enum PartType: String {
			case normal
			case bold
			case italic
			case boldItalic
			case inlineCode
			case escapedChar
		}
		
		internal init(type: TextParser.PartRegExp.PartType, pattern: String) {
			self.type = type
			self.regex = try! NSRegularExpression(pattern: pattern)
		}
	}
	
	private let partRegexes = [
		PartRegExp(type: .escapedChar, pattern: #"^\\([\\\`\*\_\{\}\[\]\<\>\(\)\+\-\.\!\|#]){1}"#),
		PartRegExp(type: .normal, pattern: #"^(.*?)(?=[\*`\\]|$)"#),
		PartRegExp(type: .boldItalic, pattern: #"^\*\*\*(.*?)\*\*\*"#),
		PartRegExp(type: .bold, pattern: #"^\*\*(.*?)\*\*"#),
		PartRegExp(type: .italic, pattern: #"^\*(.*?)\*"#),
		PartRegExp(type: .inlineCode, pattern: #"^`(.*?)`"#)
	]
	
	public func parse(rawtext text: String) -> Text {
		var parts = [Text.Part]()
		var range = NSRange(text.startIndex..., in: text)
		
		while range.location != NSNotFound && range.length != 0 {
			let startPartsCount = parts.count
			for partRegex in partRegexes {
				if let match = partRegex.regex.firstMatch(in: text, range: range),
				   let group0 = Range(match.range(at: 0), in: text),
				   let group1 = Range(match.range(at: 1), in: text) {
					
					let extractedText = String(text[group1])
					if !extractedText.isEmpty {
						switch partRegex.type {
						case .normal:
							parts.append(.normal(text: extractedText))
						case .bold:
							parts.append(.bold(text: extractedText))
						case .italic:
							parts.append(.italic(text: extractedText))
						case .boldItalic:
							parts.append(.boldItalic(text: extractedText))
						case .inlineCode:
							parts.append(.inlineCode(text: extractedText))
						case .escapedChar:
							parts.append(.escapedChar(char: extractedText))
						}

						range = NSRange(group0.upperBound..., in: text)
						break
					}
				}
			}

			if parts.count == startPartsCount {
				let extractedText = String(text[Range(range, in: text)!])
				parts.append(.normal(text: extractedText))
				break
			}
		}
		
		return Text(text: parts)
	}
}
