//
//  HtmlVisitor.swift
//
//
//  Created by Alexey Turulin on 2/26/24.
//

import Foundation

/// Converts markdown document elements into HTML strings.
public final class HtmlVisitor: IVisitor {

	/// Visits a document node and converts it to an HTML string.
	/// - Parameter node: The document node to visit.
	/// - Returns: An array of HTML strings representing the document content.
	public func visit(node: Document) -> [String] {
		visitChildren(of: node)
	}

	/// Converts a header node to an HTML header tag string.
	/// - Parameter node: The header node to convert.
	/// - Returns: An HTML header tag string with appropriate level and content.
	public func visit(node: HeaderNode) -> String {
		let text = visitChildren(of: node).joined()
		return "<h\(node.level)>\(text)</h\(node.level)>"
	}

	/// Converts a paragraph node to an HTML paragraph tag string.
	/// - Parameter node: The paragraph node to convert.
	/// - Returns: An HTML paragraph tag string with node's content.
	public func visit(node: ParagraphNode) -> String {
		let text = visitChildren(of: node).joined()
		return "<p>\(text)</p>"
	}

	/// Converts a blockquote node to an HTML blockquote tag string.
	/// - Parameter node: The blockquote node to convert.
	/// - Returns: An HTML blockquote tag string with node's content.
	public func visit(node: BlockquoteNode) -> String {
		let text = visitChildren(of: node).joined()
		return "<blockquote><p>\(text)</p></blockquote>"
	}

	/// Converts a text node to a string.
	/// - Parameter node: The text node to convert.
	/// - Returns: The text content of the node.
	public func visit(node: TextNode) -> String {
		node.text
	}

	/// Converts a bold text node to an HTML strong tag string.
	/// - Parameter node: The bold text node to convert.
	/// - Returns: An HTML strong tag string with node's content.
	public func visit(node: BoldTextNode) -> String {
		"<strong>\(node.text)</strong>"
	}

	/// Converts an italic text node to an HTML em tag string.
	/// - Parameter node: The italic text node to convert.
	/// - Returns: An HTML em tag string with node's content.
	public func visit(node: ItalicTextNode) -> String {
		"<em>\(node.text)</em>"
	}

	/// Converts a bold italic text node to an HTML string with both strong and em tags.
	/// - Parameter node: The bold italic text node to convert.
	/// - Returns: An HTML string with both strong and em tags with node's content.
	public func visit(node: BoldItalicTextNode) -> String {
		"<strong><em>\(node.text)</em></strong>"
	}

	/// Returns the escaped character without any HTML conversion.
	 /// - Parameter node: The escaped character node.
	 /// - Returns: The escaped character as a string.
	public func visit(node: EscapedCharNode) -> String {
		node.char
	}

	/// Returns the empty string without any HTML conversion.
	/// - Parameter node: The code block node.
	/// - Returns: An empty string.
	public func visit(node: CodeBlockNode) -> String {
		""
	}

	/// Converts a code line node to an HTML code tag string.
	/// - Parameter node: The code line node to convert.
	/// - Returns: An HTML code tag string with node's content.
	public func visit(node: CodeLineNode) -> String {
		"<code>\(node.text)</code>"
	}

	/// Converts an inline code node to an HTML code tag string.
	/// - Parameter node: The inline code node to convert.
	/// - Returns: An HTML code tag string with node's content.
	public func visit(node: InlineCodeNode) -> String {
		"<code>\(node.code)</code>"
	}

	/// Converts a line break node to an HTML break tag string.
	/// - Parameter node: The line break node to convert.
	/// - Returns: An HTML break tag string.
	public func visit(node: LineBreakNode) -> String {
		"<br/"
	}

	/// Converts an image node to an HTML image tag string.
	/// - Parameter node: The image node to convert.
	/// - Returns: An HTML image tag string with the node's URL and size.
	public func visit(node: ImageNode) -> String {
		"<img src=\"\(node.url)>\" />"
	}

	/// Converts an ordered list node to an HTML ordered list tag string.
	/// - Parameter node: The ordered list node to convert.
	/// - Returns: An HTML ordered list tag string.
	public func visit(node: OrderedListNode) -> String {
		""
	}

	/// Converts an unordered list node to an HTML unordered list tag string.
	/// - Parameter node: The unordered list node to convert.
	/// - Returns: An HTML unordered list tag string.
	public func visit(node: UnorderedListNode) -> String {
		""
	}

	/// Converts a line node to an empty HTML string.
	/// - Parameter node: The line node to convert.
	/// - Returns: An empty string.
	public func visit(node: LineNode) -> String {
		""
	}

	public func visit(node: LinkNode) -> String {
		""
	}
}
