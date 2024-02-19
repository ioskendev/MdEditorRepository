//
//  Token.swift
//
//
//  Created by Alexey Turulin on 2/14/24.
//

import Foundation

public enum Token {
	case header(level: Int, text: Text)
	case blockquote(level: Int, text: Text)
	case codeBlockMarker(level: Int, lang: String)
	case codeLine(text: String)
	case textLine(text: Text)
	case unorderedListItem(level: Int, text: Text)
	case orderedListItem(level: Int, text: Text)
	case link(url: String, text: String)
	case image(url: String, size: Int)
	case lineBreak
}

public struct Text {
	let text: [Part]
	
	enum Part {
		case normal(text: String)
		case bold(text: String)
		case italic(text: String)
		case boldItalic(text: String)
		case inlineCode(text: String)
		case escapedChar(char: String)
	}
}
