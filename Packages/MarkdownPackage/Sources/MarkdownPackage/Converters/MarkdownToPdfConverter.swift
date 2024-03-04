//
//  MarkdownToPdfConverter.swift
//
//
//  Created by Alexey Turulin on 2/28/24.
//

import Foundation
import PDFKit

/// Protocol for converting markdown text into a PDF document.
public protocol IMarkdownToPdfConverter {

	/// Converts markdown text into a PDF document.
	/// - Parameters:
	///   - markdownText: A string containing markdown formatted text.
	///   - author: The author of the document.
	///   - title: The title of the document
	/// - Returns: A Data object representing the generated PDF document.
	func convert(markdownText: String, author: String, title: String) -> Data
}

/// A MarkdownToPdfConverter class responsible for converting markdown text into a PDF document.
public final class MarkdownToPdfConverter: IMarkdownToPdfConverter {

	// MARK: - Dependencies

	private let visitor = AttributedTextVisitor()
	private let markdownToDocument = MarkdownToDocument()

	// MARK: - Initialization

	/// Initializes a MarkdownToPdfConverter instance.
	public init() { }

	// MARK: - Public Methods

	/// Converts markdown text into a PDF document.
	/// - Parameters:
	///   - markdownText: A string containing markdown formatted text.
	///   - author: The author of the document.
	///   - title: The title of the document
	/// - Returns: A Data object representing the generated PDF document.
	public func convert(markdownText: String, author: String, title: String) -> Data {
		let document = markdownToDocument.convert(markdownText: markdownText)

		let lines = document.accept(visitor: visitor)

		let pdfMetaData = [
			kCGPDFContextAuthor: author,
			kCGPDFContextTitle: title
		]

		let format = UIGraphicsPDFRendererFormat()
		format.documentInfo = pdfMetaData as [String: Any]

		let pageRect = CGRect(x: 10, y: 10, width: 595.2, height: 841.8)
		let graphicsRenderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

		let data = graphicsRenderer.pdfData { context in
			context.beginPage()

			var cursor: CGFloat = 40

			lines.forEach { line in
				cursor = addAttributedText(
					context: context,
					text: line,
					indent: 24.0,
					cursor: cursor,
					pdfSize: pageRect.size
				)

				cursor += 24
			}
		}

		return data
	}
}

private extension MarkdownToPdfConverter {
	func addAttributedText(
		context: UIGraphicsPDFRendererContext,
		text: NSAttributedString,
		indent: CGFloat,
		cursor: CGFloat,
		pdfSize: CGSize
	) -> CGFloat {
		let pdfTextHeight = textHeight(text, withConstrainedWidth: pdfSize.width - 2 * indent)

		let rect = CGRect(x: indent, y: cursor, width: pdfSize.width - 2 * indent, height: pdfTextHeight)
		text.draw(in: rect)

		return checkContext(context: context, cursor: rect.origin.y + rect.size.height, pdfSize: pdfSize)
	}

	func textHeight(_ text: NSAttributedString, withConstrainedWidth width: CGFloat) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

		return ceil(boundingBox.height)
	}

	func checkContext(context: UIGraphicsPDFRendererContext, cursor: CGFloat, pdfSize: CGSize) -> CGFloat {
		if cursor > pdfSize.height - 100 {
			context.beginPage()
			return 40
		}
		return cursor
	}
}
