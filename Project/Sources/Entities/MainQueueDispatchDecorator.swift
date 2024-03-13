//
//  MainQueueDispatchDecorator.swift
//  MdEditor
//
//  Created by Alexey Turulin on 3/8/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation
import MarkdownPackage

/// A decorator for 'IMarkdownToPdfConverter'.
final class MainQueueDispatchDecorator: IMarkdownToPdfConverter {

	// MARK: - Dependencies

	private let decoratee: IMarkdownToPdfConverter

	// MARK: - Initialization

	/// Initializes a new instance with the given markdown to PDF converter.
	/// - Parameter decoratee: The actual converter.
	init(decoratee: IMarkdownToPdfConverter) {
		self.decoratee = decoratee
	}

	// MARK: - Public Methods

	/// Converts markdown text into a PDF document, ensuring that the conversion process is executed
	/// on a background thread and the completion handler is called on the main thread.
	/// - Parameters:
	///   - markdownText: The markdown formatted text to convert.
	///   - author: The author of the PDF document.
	///   - title: The title of the PDF document.
	///   - pageFormat: The format for the PDF pages.
	///   - completion: A completion handler that is called with the resulting PDF data.
	func convert(
		markdownText: String,
		author: String,
		title: String,
		pageFormat: MarkdownPackage.PageFormat,
		completion: @escaping (Data) -> Void
	) {
		DispatchQueue.global(qos: .userInitiated).async {
			// Just for simulating intense activity.
			sleep(1)
			self.decoratee.convert(
				markdownText: markdownText,
				author: author,
				title: title,
				pageFormat: pageFormat
			) { data in
				self.doInMainThread {
					completion(data)
				}
			}
		}
	}

	// MARK: - Private Methods

	private func doInMainThread(_ work: @escaping () -> Void) {
		if Thread.isMainThread {
			work()
		} else {
			DispatchQueue.main.async(execute: work)
		}
	}
}
