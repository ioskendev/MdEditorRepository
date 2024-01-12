//
//  Sizes.swift
//  MdEdit
//
//  Created by Yuri Volegov on 12.01.2024.
//

import Foundation

// swiftlint:disable type_name
enum Sizes {

	static let cornerRadius: CGFloat = 6
	static let borderWidth: CGFloat = 1
	static let topInset: CGFloat = 180.0

	enum Padding {
		static let half: CGFloat = 8
		static let normal: CGFloat = 16
		static let double: CGFloat = 32
	}

	enum L {
		static let width: CGFloat = 200
		static let height: CGFloat = 50
		static let widthMultiplier: CGFloat = 0.9
	}

	enum M {
		static let width: CGFloat = 100
		static let height: CGFloat = 40
	}

	enum S {
		static let width: CGFloat = 80
		static let height: CGFloat = 30
	}
}
// swiftlint:enable type_name
