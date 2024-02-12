//
//  MarkdownToHTMLConverter.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/10/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

protocol IMarkdownToHTMLConverter {
	func convert(_ text: String) -> String
}

final class MarkdownToHTMLConverter: IMarkdownToHTMLConverter {

	// MARK: - Private properties

	private var isStartCode = false

	// MARK: - Public methods

	func convert(_ text: String) -> String {

		let lines = text.components(separatedBy: .newlines)
		var html = [String?]()

		lines.forEach { line in
			html.append(parseHeader(text: line))
			html.append(parseBlockquote(text: line))
			html.append(parseParagraph(text: line))
			html.append(parseCodeBlock(text: line))
		}

		return makeHTML(html.compactMap { $0 }.joined())
	}
}

extension MarkdownToHTMLConverter {
	func makeHTML(_ text: String) -> String {
		let backgroundColor = Theme.backgroundColor.toHex()! // swiftlint:disable:this force_unwrapping
		let textColor = Theme.black.toHex()! // swiftlint:disable:this force_unwrapping

		let html = """
		<!DOCTYPE html>
		<html>
			<head>
				<style>
					body {
						font-size: 350%;color:#\(textColor);
						background-color:#\(backgroundColor);
					}
				</style>
			</head>
			<body>
				\(text)
			</body>
		</html>
		"""
		return html
	}

	func parseHeader(text: String) -> String? {

		let pattern = #"^(?<headerLevel>#{1,6})\s+(?<headerText>.+)"#
		let range = NSRange(text.startIndex..., in: text)
		let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)

		var headerLevel: Int?
		var headerText: String?

		if let match = regex?.firstMatch(in: text, range: range) {
			if let headerLevelRange = Range(
				match.range(withName: "headerLevel"),
				in: text
			) {
				headerLevel = String(text[headerLevelRange]).count
			}

			if let headerTextRange = Range(
				match.range(withName: "headerText"),
				in: text
			) {
				headerText = String(text[headerTextRange])
			}
		}

		if let headerLevel, let headerText {
			return "<h\(headerLevel)>\(headerText)</h\(headerLevel)>"
		}

		return nil
	}

	func parseBlockquote(text: String) -> String? {

		let pattern = #"^>\s+(.+)"#
		let range = NSRange(text.startIndex..., in: text)
		let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)

		if let match = regex?.firstMatch(in: text, range: range) {
			if let range = Range(
				match.range(at: 1),
				in: text
			) {
				let blockquoteText = parseText(String(text[range]))
				return "<blockquote><p>\(blockquoteText)</p></blockquote>"
			}
		}

		return nil
	}

	func parseCodeBlock(text: String) -> String? {

		let pattern = #"^`{3}"#
		let range = NSRange(text.startIndex..., in: text)
		let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)

		if regex?.firstMatch(in: text, range: range) != nil {
			isStartCode.toggle()
			if isStartCode {
				return "<code>"
			} else {
				return "</code>"
			}
		}

		return nil
	}

	func parseText(_ text: String) -> String {
		let boldItalicPattern = #"\*\*\*(.+?)\*\*\*"#
		let boldPattern = #"\*\*(.+?)\*\*"#
		let italicPattern = #"\*(.+?)\*"#

		var result = text

		result = text.replacingOccurrences(
			of: boldItalicPattern,
			with: "<strong><em>$1</em></strong>",
			options: .regularExpression
		)

		result = result.replacingOccurrences(
			of: boldPattern,
			with: "<strong>$1</strong>",
			options: .regularExpression
		)

		result = result.replacingOccurrences(
			of: italicPattern,
			with: "<em>$1</em>",
			options: .regularExpression
		)

		return result
	}

	func parseParagraph(text: String) -> String? {

		let pattern = #"^([^#>`].*)"#
		let range = NSRange(text.startIndex..., in: text)
		let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)

		if let match = regex?.firstMatch(in: text, range: range) {
			if let range = Range(
				match.range(at: 1), in: text
			) {
				let paragraphText = parseText(String(text[range]))
				return "<p>\(paragraphText)</p>"
			}
		}

		return nil
	}
}
