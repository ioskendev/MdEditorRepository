//
//  Nodes.swift
//
//
//  Created by Alexey Turulin on 2/18/24.
//

import Foundation

public protocol INode {
	var children: [INode] { get }
}

public class BaseNode: INode {
	private(set) public var children: [INode]

	public init(_ children: [INode] = []) {
		self.children = children
	}
}

public final class Document: BaseNode {
}

public final class HeaderNode: BaseNode {
	let level: Int

	public init(level: Int, children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}

public final class BlockquoteNode: BaseNode {
	let level: Int

	public init(level: Int, children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}


public final class ParagraphNode: BaseNode {
}

public final class TextNode: BaseNode {
	let text: String

	public init(text: String) {
		self.text = text
	}
}

public final class BoldTextNode: BaseNode {
	let text: String

	public init(text: String) {
		self.text = text
	}
}

public final class ItalicTextNode: BaseNode {
	let text: String

	public init(text: String) {
		self.text = text
	}
}

public final class BoldItalicTextNode: BaseNode {
	let text: String

	public init(text: String) {
		self.text = text
	}
}

public final class InlineCodeNode: BaseNode {
	let code: String

	public init(code: String) {
		self.code = code
	}
}

public final class EscapedCharNode: BaseNode {
	let char: String

	public init(char: String) {
		self.char = char
	}
}

public final class LineBreakNode: BaseNode {
	public init() { }
}

public final class ImageNode: BaseNode {
	let url: String
	let size: String

	public init(url: String, size: String) {
		self.url = url
		self.size = size
	}
}
