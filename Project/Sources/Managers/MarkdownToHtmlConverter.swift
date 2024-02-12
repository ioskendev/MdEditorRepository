//
//  MarkdownToHtmlConverter.swift
//  MdEditor
//
//  Created by ioskendev on 12.01.2024.
//

import Foundation

protocol IMarkdownToHtmlConverter {
	func convert(_ text: String) -> String
}

final class MarkdownToHtmlConverter: IMarkdownToHtmlConverter {
	// MARK: - Public methods

	func convert(_ text: String) -> String {
		let lines = text.components(separatedBy: .newlines)
		var html = [String?]()

		lines.forEach { line in
			html.append(parseHeader(text: line))
			html.append(parseBlockquote(text: line))
			html.append(parseParagraph(text: line))
		}

		return makeHtml(html.compactMap { $0 }.joined())
	}
}

private extension MarkdownToHtmlConverter {
	func makeHtml(_ text: String) -> String {
		"<!DOCTYPE html><html><head><style> body {font-size: 350%;} </style></head><body>\(text)<body></html>"
	}

	func parseHeader(text: String) -> String? {
		let regex = /^(?<headerLevel>#{1,6})\s+(?<headerText>.+)/ // swiftlint:disable:this opening_brace

		if let match = text.wholeMatch(of: regex) {
			let headerLevel = String(match.headerLevel).count
			let headerText = parseText(String(match.headerText))
			return "<h\(headerLevel)>\(headerText)</h\(headerLevel)>"
		}

		return nil
	}

	func parseBlockquote(text: String) -> String? {
		let regex = /^>\s+(.+)/

		if let match = text.wholeMatch(of: regex) {
			let blockquoteText = parseText(String(match.output.1))
			return "<blockquote><p>\(blockquoteText)</p></blockquote>"
		}

		return nil
	}

	func parseParagraph(text: String) -> String? {
		let regex = /^([^#>].*)/

		if let match = text.wholeMatch(of: regex) {
			let paragrapText = parseText(String(match.output.1))
			return "<p>\(paragrapText)</p>"
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
}
