//
//  Nodes.swift
//
//
//  Created by Alexey Turulin on 2/18/24.
//

import Foundation

/// Node protocol.
public protocol INode {

	/// An array of child nodes.
	var children: [INode] { get }
}

/// BaseNode class serves as a foundational element for constracting a node hierarchy.
/// It implements the INode protocol, allowing it to store an array of child nodes.
public class BaseNode: INode {

	/// An array of child nodes.
	public private(set) var children: [INode]

	/// Initializes a new instance of BaseNode with optional child nodes.
	/// - Parameter children: An array of child nodes. Defaults to an empty array.
	public init(_ children: [INode] = []) {
		self.children = children
	}
}

/// The Document class is a specialized type of BaseNode that represents the root of a document structure.
/// It can contain various types of nodes as its children, organizing them into a coherent structure that
/// models a document.
public final class Document: BaseNode {
}

public extension Document {

	/// Allows a visitor to process this document.
	/// - Parameter visitor: A visitor conforming to the 'IVisitor' protocol.
	/// - Returns: An array of results produced by visitor's operations on the document.
	func accept<T: IVisitor>(visitor: T) -> [T.Result] {
		visitor.visit(node: self)
	}
}

/// Represents a header node in a document structure.
public final class HeaderNode: BaseNode {

	/// The level of the header, which determines its hierarchical position in the document.
	public let level: Int

	/// Initializes a header node with a specific 'level' and optional child nodes.
	/// - Parameters:
	///   - level: The level of the header, which determines its hierarchical position in the document.
	///   - children: An array of child nodes.
	public init(level: Int, children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}

/// Represents a blockquote node in a document structure.
public final class BlockquoteNode: BaseNode {

	/// The level of the blockquote, which determines its hierarchical position in the document.
	public let level: Int

	/// Initializes a blockquote node with a specific 'level' and optional child nodes.
	/// - Parameters:
	///   - level: The level of the blockquote, which determines its hierarchical position in the document.
	///   - children: An array of child nodes.
	public init(level: Int, children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}

/// Represents a paragraph node in a document structure.
public final class ParagraphNode: BaseNode {
}

/// Represents a text node in a document structure.
public final class TextNode: BaseNode {

	/// The string content of the text node.
	public let text: String

	/// Initializes a text node with provided text content.
	/// - Parameter text: The string content of the text node.
	public init(text: String) {
		self.text = text
	}
}

/// Represents a bold text node in a document structure.
public final class BoldTextNode: BaseNode {

	/// The string content of the bold text node.
	public let text: String

	/// Initializes a bold text node.
	/// - Parameter text: The string content of the bold text node.
	public init(text: String) {
		self.text = text
	}
}

/// Represents an italic text node in a document structure.
public final class ItalicTextNode: BaseNode {

	/// The string content of the italic text node.
	public let text: String

	/// Initializes an italic text node.
	/// - Parameter text: The string content of the italic text node.
	public init(text: String) {
		self.text = text
	}
}

/// Represents a bold and italic text node in a document structure.
public final class BoldItalicTextNode: BaseNode {

	/// The string content of the bold and italic text node.
	public let text: String

	/// Initializes a bold and italic text node.
	/// - Parameter text: The string content of the bold and italic text node.
	public init(text: String) {
		self.text = text
	}
}

/// Represents a code block node in a document structure.
public final class CodeBlockNode: BaseNode {

	/// An integer representing the indentation level of the code block.
	public let level: Int

	/// An optional string specifying the programming language of the code block.
	public let lang: String?

	/// Initializes a code block node.
	/// - Parameters:
	///   - level: An integer representing the indentation level of the code block.
	///   - lang: An optional string specifying the programming language of the code block.
	public init(level: Int, lang: String?) {
		self.level = level
		self.lang = lang
	}
}

/// Represents a code line node in a document structure.
public final class CodeLineNode: BaseNode {

	/// A string containing a single line of code.
	public let text: String

	/// Initializes a node representing a single line of code within a code block.
	/// - Parameter text: A string containing a single line of code.
	public init(text: String) {
		self.text = text
	}
}

/// Represents an inline code node in a document structure.
public final class InlineCodeNode: BaseNode {

	/// The string content of the inline code.
	public let code: String

	/// Initializes an inline code node.
	/// - Parameter code: The string content of the inline code.
	public init(code: String) {
		self.code = code
	}
}

/// Represents an escaped char node in a document structure.
public final class EscapedCharNode: BaseNode {

	/// The string content of the escaped char.
	public let char: String

	/// Initializes an escaped char node.
	/// - Parameter char: The string content of the escaped char.
	public init(char: String) {
		self.char = char
	}
}

/// Represents a line break node in a document structure.
public final class LineBreakNode: BaseNode {

	/// Initializes a line break node instance.
	public init() { }
}

/// Represents an image node in a document structure.
public final class ImageNode: BaseNode {

	/// The URL of the image.
	public let url: String

	/// The size of the image.
	public let size: String

	/// Initializes an image node with the source URL and size.
	/// - Parameters:
	///   - url: The URL of the image.
	///   - size: The size of the image.
	public init(url: String, size: String) {
		self.url = url
		self.size = size
	}
}

/// Represents a link node in a document structure.
public final class LinkNode: BaseNode {

	/// The visible text of the link.
	public let title: String?

	/// The destination URL.
	public let url: String

	/// Initializes a link node with an optional title and a URL.
	/// - Parameters:
	///   - title: The visible text of the link.
	///   - url: The destination URL.
	public init(title: String?, url: String) {
		self.title = title
		self.url = url
	}
}

/// Represents a task node in a document structure.
public final class TaskNode: BaseNode {

	/// A boolean value indicating whether the task is already completed.
	public let isDone: Bool

	/// Initializes a task node with a completion status and optional child nodes.
	/// - Parameters:
	///   - isDone: A boolean value indicating whether the task is already completed.
	///   - children: An array of child nodes. Defaults to an empty array.
	public init(isDone: Bool, children: [INode] = []) {
		self.isDone = isDone
		super.init(children)
	}
}

/// Represents an ordered list node in a document structure.
public final class OrderedListNode: BaseNode {

	/// The level of the list item, which determines its hierarchical position in the document.
	public let level: Int

	/// Initializes an ordered node with a specific 'level', 'text' and optional child nodes.
	/// - Parameters:
	///   - level: The level of the list item, which determines its hierarchical position in the document.
	///   - children: An array of child nodes.
	public init(level: Int, children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}

/// Represents an unordered list node in a document structure.
public final class UnorderedListNode: BaseNode {

	/// The level of the list item, which determines its hierarchical position in the document.
	public let level: Int

	/// Initializes an unordered node with a specific 'level', 'text' and optional child nodes.
	/// - Parameters:
	///   - level: The level of the list item, which determines its hierarchical position in the document.
	///   - children: An array of child nodes.
	public init(level: Int, children: [INode] = []) {
		self.level = level
		super.init(children)
	}
}

/// Represents a line node in a document structure.
public final class LineNode: BaseNode {

	/// Initializes a line node instance.
	public init() { }
}
