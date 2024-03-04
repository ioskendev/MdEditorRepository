//
//  Document+CustomStringConvertible.swift
//
//
//  Created by Alexey Turulin on 2/25/24.
//

import Foundation

extension Document: CustomStringConvertible {
	public var description: String {
		"\(children.map { "\($0)" }.joined(separator: "\n"))"
	}
}

extension HeaderNode: CustomStringConvertible {
	public var description: String {
		"Header Level: \(level)\n\t\(children.map { "\t\t\($0)" }.joined(separator: "\n"))"
	}
}

extension TextNode: CustomStringConvertible {
	public var description: String {
		"TextNode: \(text)"
	}
}

extension BoldTextNode: CustomStringConvertible {
	public var description: String {
		"BoldTextNode: \(text)"
	}
}

extension ItalicTextNode: CustomStringConvertible {
	public var description: String {
		"ItalicTextNode: \(text)"
	}
}

extension BoldItalicTextNode: CustomStringConvertible {
	public var description: String {
		"BoldItalicTextNode: \(text)"
	}
}

extension ParagraphNode: CustomStringConvertible {
	public var description: String {
		"Paragraph\n\t\(children.map { "\t\t\($0)" }.joined(separator: "\n"))"
	}
}
