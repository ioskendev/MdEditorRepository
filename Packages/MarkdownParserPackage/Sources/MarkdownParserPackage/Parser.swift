//
//  Parser.swift
//
//
//  Created by Alexey Turulin on 2/18/24.
//

import Foundation

public final class Parser {
	
	public init() { }
	
	public func parse(tokens: [Token]) -> Document {
		var tokens = tokens
		var result = [INode]()

		while !tokens.isEmpty {
			var nodes = [INode?]()
			nodes.append(parseHeader(tokens: &tokens))
			nodes.append(parseBlockquote(tokens: &tokens))
			nodes.append(parseParagraph(tokens: &tokens))
			nodes.append(parseImage(tokens: &tokens))
			nodes.append(parseLineBreak(tokens: &tokens))

			let resultNodes = nodes.compactMap { $0 }

			if resultNodes.isEmpty, !tokens.isEmpty {
				tokens.removeFirst()
			} else {
				result.append(contentsOf: resultNodes)
			}
		}

		return Document(result)
	}
}

private extension Parser {
	func parseHeader(tokens: inout [Token]) -> HeaderNode? {
		guard let token = tokens.first else {
			return nil
		}

		if case let .header(level, text) = token {
			tokens.removeFirst()
			return HeaderNode(level: level, children: parseText(token: text))
		}

		return nil
	}

	func parseBlockquote(tokens: inout [Token]) -> BlockquoteNode? {
		guard let token = tokens.first else {
			return nil
		}

		if case let .blockquote(level, text) = token {
			tokens.removeFirst()
			return BlockquoteNode(level: level, children: parseText(token: text))
		}

		return nil
	}

	func parseParagraph(tokens: inout [Token]) -> ParagraphNode? {
		var textNodes = [INode]()

		while !tokens.isEmpty {
			guard let token = tokens.first else { return nil }
			if case let .textLine(text) = token {
				tokens.removeFirst()
				textNodes.append(contentsOf:  parseText(token: text))
			} else if case .lineBreak = token {
				tokens.removeFirst()
				break
			} else {
				break
			}
		}

		if !textNodes.isEmpty {
			return ParagraphNode(textNodes)
		}

		return nil
	}

	func parseImage(tokens: inout [Token]) -> ImageNode? {
		guard let token = tokens.first else {
			return nil
		}
		
		if case let .image(url, size) = token {
			tokens.removeFirst()
			return ImageNode(url: url, size: String(size))
		}

		return nil
	}

	func parseLineBreak(tokens: inout [Token]) -> LineBreakNode? {
		guard let token = tokens.first else {
			return nil
		}
		
		if case .lineBreak = token {
			tokens.removeFirst()
			return LineBreakNode()
		}

		return nil
	}

	func parseText(token: Text) -> [INode] {
		var textNodes = [INode]()
		token.text.forEach { part in
			switch part {
			case .normal(let text):
				textNodes.append(TextNode(text: text))
			case .bold(let text):
				textNodes.append(BoldTextNode(text: text))
			case .italic(let text):
				textNodes.append(ItalicTextNode(text: text))
			case .boldItalic(let text):
				textNodes.append(BoldItalicTextNode(text: text))
			case .inlineCode(let text):
				textNodes.append(InlineCodeNode(code: text))
			case .escapedChar(let char):
				textNodes.append(EscapedCharNode(char: char))
			}
		}
		return textNodes
	}
}
