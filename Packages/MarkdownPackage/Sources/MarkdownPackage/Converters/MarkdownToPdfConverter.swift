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
	///   - author: Author of the document.
	///   - title: Title of the document
	///   - pageFormat: Format of the PDF pages.
	///   - completion:Handler to return the PDF as 'Data'
	func convert(
		markdownText: String,
		author: String,
		title: String,
		pageFormat: PageFormat,
		completion: @escaping (Data) -> Void
	)
}

/// A MarkdownToPdfConverter class responsible for converting markdown text into a PDF document.
public final class MarkdownToPdfConverter: IMarkdownToPdfConverter {

	private struct Cursor {
		static let initialPosition: CGFloat = 40
		static let indent: CGFloat = 12

		var position: CGFloat = Cursor.initialPosition
	}

	// MARK: - Dependencies

	private let theme: IAttributedTextColors
	private let visitor: AttributedTextVisitor
	private let markdownToDocument = MarkdownToDocument()

	// MARK: - Initialization

	/// Initializes a MarkdownToPdfConverter instance.
	public init(theme: IAttributedTextColors) {
		self.theme = theme
		visitor = AttributedTextVisitor(theme: theme)
	}

	// MARK: - Public Methods

	/// Converts markdown text into a PDF document.
	/// - Parameters:
	///   - markdownText: A string containing markdown formatted text.
	///   - author: Author of the document.
	///   - title: Title of the document
	///   - pageFormat: Format of the PDF pages.
	///   - completion:Handler to return the PDF as 'Data'
	public func convert(
		markdownText: String,
		author: String,
		title: String,
		pageFormat: PageFormat,
		completion: @escaping (Data) -> Void
	) {

		let document = markdownToDocument.convert(markdownText: markdownText)
		let format = UIGraphicsPDFRendererFormat()

		let pdfMetaData = [
			kCGPDFContextAuthor: author,
			kCGPDFContextTitle: title
		]

		format.documentInfo = pdfMetaData as [String: Any]

		let pageRect = CGRect(
			x: pageFormat.size.x,
			y: pageFormat.size.y,
			width: pageFormat.size.width,
			height: pageFormat.size.height
		)

		let graphicsRenderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

		let lines = document.accept(visitor: visitor)

		let data = graphicsRenderer.pdfData { context in
			context.beginPage()

			var cursor = Cursor()

			lines.forEach { line in
				cursor.position = self.addAttributedText(
					context: context,
					text: line,
					indent: Cursor.indent,
					cursor: cursor.position,
					pdfSize: pageRect.size
				)

				cursor.position += Cursor.indent
			}
		}

		completion(data)
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

		let rect = CGRect(
			x: 2 * indent,
			y: cursor,
			width: pdfSize.width - 2 * indent,
			height: pdfTextHeight
		)

		text.draw(in: rect)

		return checkContext(
			context: context,
			cursor: rect.origin.y + rect.size.height,
			pdfSize: pdfSize
		)
	}

	func textHeight(_ text: NSAttributedString, withConstrainedWidth width: CGFloat) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

		return ceil(boundingBox.height)
	}

	func checkContext(
		context: UIGraphicsPDFRendererContext,
		cursor: CGFloat,
		pdfSize: CGSize
	) -> CGFloat {
		if cursor > pdfSize.height - 100 {
			context.beginPage()
			return Cursor.initialPosition
		}

		return cursor
	}
}

/// Represents page formats.
public enum PageFormat {
	// swiftlint:disable identifier_name

	/// Represents A4 page format.
	case a4

	struct PageSize {
		let x: Double = 10
		let y: Double = 10
		let width: Double
		let height: Double

		init(width: Double, height: Double) {
			self.width = width / 25.4 * 72
			self.height = height / 25.4 * 72
		}
	}

	var size: PageSize {
		switch self {
		case .a4:
			return PageSize(width: 210, height: 297)
		}
	}
}
