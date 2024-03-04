//
//  Sequence+joined.swift
//
//
//  Created by Alexey Turulin on 2/26/24.
//

import Foundation

public extension Sequence where Iterator.Element == NSMutableAttributedString {

	/// Concatenates the elements of the sequence, creating a single 'NSMutableAttributedString'.
	/// - Returns: A 'NSMutableAttributedString' containing the concatenated elements of the sequence.
	func joined() -> NSMutableAttributedString {
		reduce(into: NSMutableAttributedString()) { $0.append($1) }
	}
}
