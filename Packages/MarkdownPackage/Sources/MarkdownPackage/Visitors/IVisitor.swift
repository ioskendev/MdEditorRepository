//
//  IVisitor.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/26/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

/// The visitor protocol defines a set of methods for visiting different types of nodes in a document's structure.
public protocol IVisitor {

	/// Represents the type of result produced by visiting nodes.
	associatedtype Result

	/// Visit the root document node.
	/// - Parameter node: The document node to visit.
	/// - Returns: An array of results generated from visiting the document.
	func visit(node: Document) -> [Result]

	/// Visits a header node.
	/// - Parameter node: The header node to visit.
	/// - Returns: A result generated from visiting the document.
	func visit(node: HeaderNode) -> Result

	/// Visits a paragraph node.
	/// - Parameter node: The paragraph node to visit.
	/// - Returns: A result generated from visiting the document.
	func visit(node: ParagraphNode) -> Result

	/// Visits a blockquote node.
	/// - Parameter node: The blockquote node to visit.
	/// - Returns: A result generated from visiting the document.
	func visit(node: BlockquoteNode) -> Result

	/// Visits a code block node.
	/// - Parameter node: The code block node to visit.
	/// - Returns: A result generated from visiting the document.
	func visit(node: CodeBlockNode) -> Result

	/// Visits a code line node.
	/// - Parameter node: The code line node to visit.
	/// - Returns: A result generated from visiting the document.
	func visit(node: CodeLineNode) -> Result

	/// Visits a text node.
	/// - Parameter node: The text node to visit.
	/// - Returns: A result generated from visiting the document.
	func visit(node: TextNode) -> Result

	/// Visits a bold text node.
	/// - Parameter node: The bold text node to visit.
	/// - Returns: A result generated from visiting the document.
	func visit(node: BoldTextNode) -> Result

	/// Visits a italic text node.
	/// - Parameter node: The italic text node to visit.
	/// - Returns: A result generated from visiting the document.
	func visit(node: ItalicTextNode) -> Result

	/// Visits a bold and italic node.
	/// - Parameter node: The bold and italic text node to visit.
	/// - Returns: A result generated from visiting the document.
	func visit(node: BoldItalicTextNode) -> Result

	/// Visits a escaped char node.
	/// - Parameter node: The escaped char node to visit.
	/// - Returns: A result generated from visiting the document.
	func visit(node: EscapedCharNode) -> Result

	/// Visits a inline code node.
	/// - Parameter node: The inline code node to visit.
	/// - Returns: A result generated from visiting the document.
	func visit(node: InlineCodeNode) -> Result

	/// Visits a line break node.
	/// - Parameter node: The line break node to visit.
	/// - Returns: A result generated from visiting the document.
	func visit(node: LineBreakNode) -> Result

	/// Visits an image node.
	/// - Parameter node: The image node to visit.
	/// - Returns: A result generated from visiting the document.
	func visit(node: ImageNode) -> Result

	/// Visits an ordered list node.
	/// - Parameter node: The ordered list node to visit.
	/// - Returns: A result generated from visiting the document.
	func visit(node: OrderedListNode) -> Result

	/// Visits an unordered list node.
	/// - Parameter node: The unordered list node to visit.
	/// - Returns: A result generated from visiting the document.
	func visit(node: UnorderedListNode) -> Result

	/// Visits a line node.
	/// - Parameter node: The line node to visit.
	/// - Returns: A result generated from visiting the document.
	func visit(node: LineNode) -> Result

	/// Visits a link node.
	/// - Parameter node: The link node to visit.
	/// - Returns: A result generated from visiting the document.
	func visit(node: LinkNode) -> Result
}

public extension IVisitor {

	/// Visits all children of a given node and returns the collevtive results.
	/// this method iterates through each child node of the given node,
	/// dispathing to the appropiate 'visit(node:)' method based on the child's type.
	/// - Parameter node: The parent node.
	/// - Returns: An array of results from visiting each child excluding any 'nil' values.
	func visitChildren(of node: INode) -> [Result] {
		return node.children.compactMap { child in // swiftlint:disable:this closure_body_length
			switch child {
			case let child as HeaderNode:
				return visit(node: child)
			case let child as ParagraphNode:
				return visit(node: child)
			case let child as BlockquoteNode:
				return visit(node: child)
			case let child as TextNode:
				return visit(node: child)
			case let child as BoldTextNode:
				return visit(node: child)
			case let child as ItalicTextNode:
				return visit(node: child)
			case let child as BoldItalicTextNode:
				return visit(node: child)
			case let child as CodeBlockNode:
				return visit(node: child)
			case let child as CodeLineNode:
				return visit(node: child)
			case let child as InlineCodeNode:
				return visit(node: child)
			case let child as LineBreakNode:
				return visit(node: child)
			case let child as ImageNode:
				return visit(node: child)
			case let child as OrderedListNode:
				return visit(node: child)
			case let child as UnorderedListNode:
				return visit(node: child)
			case let child as LineNode:
				return visit(node: child)
			case let child as LinkNode:
				return visit(node: child)
			default:
				return nil
			}
		}
	}
}
