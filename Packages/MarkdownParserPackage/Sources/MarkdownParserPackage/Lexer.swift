//
//  Lexer.swift
//
//
//  Created by Alexey Turulin on 2/14/24.
//

import Foundation

public protocol ILexer {
	func tokenize(_ input: String) -> [Token]
}

public final class Lexer: ILexer {
	
	// MARK: - Dependencies
	
	private let textParser: ITextParser
	
	// MARK: - Initializers
	
	public init() {
		self.textParser = TextParser()
	}
	
	// MARK: - Public methods
	
	public func tokenize(_ input: String) -> [Token] {
		
		let lines = input.components(separatedBy: .newlines)
		var tokens = [Token?]()
		var inCodeBlock = false
		
		for line in lines {
			
			if let codeBlockToken = parseCodeBlockMarker(rawText: line) {
				tokens.append(codeBlockToken)
				inCodeBlock.toggle()
				continue
			}
			
			if !inCodeBlock {
				tokens.append(parseLineBreak(rawText: line))
				tokens.append(parseHeader(rawText: line))
				tokens.append(parseBlockquote(rawText: line))
				tokens.append(parseTextLine(rawText: line))
			} else {
				tokens.append(.codeLine(text: line))
			}
		}
	
		return tokens.compactMap { $0 }
	}
}

private extension Lexer {
	
	// MARK: - Private methods
	
	func parseLineBreak(rawText: String) -> Token? {
		if rawText.isEmpty {
			return .lineBreak
		}
		
		return nil
	}
	
	func parseHeader(rawText: String) -> Token? {
		let pattern = #"^(?<headerLevel>#{1,6})\s+(?<headerText>.+)"#
		let range = NSRange(rawText.startIndex..., in: rawText)
		let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
		
		var headerLevel: Int?
		var headerText: Text?
		
		if let match = regex.firstMatch(in: rawText, range: range) {

			if let headerLevelRange = Range(match.range(withName: "headerLevel"), in: rawText) {
				headerLevel = String(rawText[headerLevelRange]).count
			}
			
			if let headerTextRange = Range(match.range(withName: "headerText"), in: rawText) {
				headerText = parseText(String(rawText[headerTextRange]))
			}
		}
		
		if let headerLevel, let headerText {
			return .header(level: headerLevel, text: headerText)
		}

		return nil
	}
	
	func parseBlockquote(rawText: String) -> Token? {
		let pattern = #"^(>{1,6})\s+(.+)"#
		let range = NSRange(rawText.startIndex..., in: rawText)
		let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
		
		var blockquoteLevel: Int?
		var blockquoteText: Text?
		
		if let match = regex.firstMatch(in: rawText, range: range) {
			if let blockquoteLevelRange = Range(match.range(at: 1), in: rawText) {
				blockquoteLevel = String(rawText[blockquoteLevelRange]).count
			}
			
			if let blockquoteTextRange = Range(match.range(at: 2), in: rawText) {
				blockquoteText = parseText(String(rawText[blockquoteTextRange]))
			}
		}
		
		if let blockquoteLevel, let blockquoteText {
			return .blockquote(level: blockquoteLevel, text: blockquoteText)
		}
		
		return nil
	}
	
	func parseTextLine(rawText: String) -> Token? {
		if rawText.isEmpty { return nil }
		
		let pattern = #"^([^#>].*)"#
		let range = NSRange(rawText.startIndex..., in: rawText)
		let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
		
		if let match = regex.firstMatch(in: rawText, range: range) {
			if let range = Range(match.range(at: 1), in: rawText) {
				let paragraphText = parseText(String(rawText[range]))
				return .textLine(text: paragraphText)
			}
		}
		
		return nil
	}

	func parseCodeBlockMarker(rawText: String) -> Token? {
		let pattern = #"^`{2,6}(.*)"#

		if let text = rawText.group(for: pattern) {
			let level = rawText.filter { $0 == "`" }.count
			return .codeBlockMarker(level: level, lang: text)
		}
		
		return nil
	}
	
	func parseText(_ rawText: String) -> Text {
		textParser.parse(rawtext: rawText)
	}
	
}
