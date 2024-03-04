//
//  Parser.swift
//
//
//  Created by Alexey Turulin on 2/18/24.
//

import Foundation

/// Represents the parser responsible for converting tokens into a structured document.
public final class Parser {

	/// Initializes a new Parser instance.
	public init() { }

	/// Parses a sequence of tokens into a document structure.
	/// - Parameter tokens: An array of Token objects representing the parsed elements of markdown text.
	/// - Returns: A Document object that represents the structured hierarchy of the parsed tokens.
	public func parse(tokens: [Token]) -> Document {
		let tokens = tokens
		var nodes = [INode?]()
		var inCodeBlock = false

		for token in tokens {

			if let codeBlockNode = parseCodeBlock(token: token) {
				nodes.append(CodeBlockNode(level: codeBlockNode.level, lang: codeBlockNode.lang))
				inCodeBlock.toggle()
			}

			if !inCodeBlock {
				nodes.append(parseLineBreak(token: token))
				nodes.append(parseHeader(token: token))
				nodes.append(parseBlockquote(token: token))
				nodes.append(parseParagraph(token: token))
				nodes.append(parseTask(token: token))
				nodes.append(parseOrderedList(token: token))
				nodes.append(parseUnorderedList(token: token))
				nodes.append(parseLine(token: token))
				nodes.append(parseLink(token: token))
				nodes.append(parseImage(token: token))
			} else {
				nodes.append(parseCodeLine(token: token))
			}
		}

		return Document(nodes.compactMap { $0 })
	}
}

private extension Parser {
	func parseHeader(token: Token) -> HeaderNode? {
		if case let .header(level, text) = token {
			return HeaderNode(level: level, children: parseText(token: text))
		}

		return nil
	}

	func parseBlockquote(token: Token) -> BlockquoteNode? {
		if case let .blockquote(level, text) = token {
			return BlockquoteNode(level: level, children: parseText(token: text))
		}

		return nil
	}

	func parseParagraph(token: Token) -> ParagraphNode? {
		var textNodes = [INode]()

			if case let .textLine(text) = token {
				textNodes.append(contentsOf: parseText(token: text))
			}

		if !textNodes.isEmpty {
			return ParagraphNode(textNodes)
		}

		return nil
	}

	func parseCodeBlock(token: Token) -> CodeBlockNode? {

		if case let .codeBlockMarker(level, lang) = token {
			return CodeBlockNode(level: level, lang: lang)
		}

		return nil
	}

	func parseCodeLine(token: Token) -> CodeLineNode? {

		if case let .codeLine(text) = token {
			return CodeLineNode(text: text)
		}

		return nil
	}

	func parseImage(token: Token) -> ImageNode? {

		if case let .image(url, size) = token {
			return ImageNode(url: url, size: String(size))
		}

		return nil
	}

	func parseLineBreak(token: Token) -> LineBreakNode? {

		if case .lineBreak = token {
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

	func parseTask(token: Token) -> TaskNode? {
		if case let .task(isDone, text) = token {
			return TaskNode(isDone: isDone, children: parseText(token: text))
		}

		return nil
	}

	func parseOrderedList(token: Token) -> OrderedListNode? {
		if case let .orderedListItem(level, text) = token {
			return OrderedListNode(level: level, children: parseText(token: text))
		}

		return nil
	}

	func parseUnorderedList(token: Token) -> UnorderedListNode? {
		if case let .unorderedListItem(level, text) = token {
			return UnorderedListNode(level: level, children: parseText(token: text))
		}

		return nil
	}

	func parseLine(token: Token) -> LineNode? {
		if case .line = token {
			return LineNode()
		}

		return nil
	}

	func parseLink(token: Token) -> LinkNode? {
		if case let .link(url, text) = token {
			return LinkNode(title: text, url: url)
		}

		return nil
	}
}
