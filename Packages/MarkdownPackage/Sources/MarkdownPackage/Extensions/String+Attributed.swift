//
//  String+Attributed.swift
//
//
//  Created by Alexey Turulin on 2/26/24.
//

import Foundation

extension String {
	var attributed: NSMutableAttributedString {
		NSMutableAttributedString(string: self)
	}

	static var lineBreak: NSMutableAttributedString {
		NSMutableAttributedString(string: "\n")
	}

	static var tab: NSMutableAttributedString {
		NSMutableAttributedString(string: "\t")
	}
}
