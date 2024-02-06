//
//  Predicates.swift
//  MdEditor
//
//  Created by Alexey Turulin on 1/17/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import Foundation

enum Predicate {
	case contains(String)
	case doesNotContain(String)

	case exists
	case doesNotExist

	case `is`(String) // swiftlint:disable:this identifier_name
	case isNot(String)

	case isLike(String)
	case isNotLike(String)

	case isHittable
	case isNotHittable

	case isEnabled
	case isNotEnabled

	case isSelected
	case isNotSelected

	var format: String {
		switch self {

		case .contains(let value):
			return "label == \"\(value.replacingOccurrences(of: "\"", with: "\\\""))\""
		case .doesNotContain(let value):
			return "label != \"\(value.replacingOccurrences(of: "\"", with: "\\\""))\""
		case .exists:
			return "exists == true"
		case .doesNotExist:
			return "exists == false"
		case .is(let value):
			return "label == \"\(value.replacingOccurrences(of: "\"", with: "\\\""))\""
		case .isNot(let value):
			return "label != \"\(value.replacingOccurrences(of: "\"", with: "\\\""))\""
		case .isLike(let value):
			return "label LIKE[cd] \"\(value.replacingOccurrences(of: "\"", with: "\\\""))\""
		case .isNotLike(let value):
			return "label NOT LIKE[cd] \"\(value.replacingOccurrences(of: "\"", with: "\\\""))\""
		case .isHittable:
			return "isHittable == true"
		case .isNotHittable:
			return "isHittable == false"
		case .isEnabled:
			return "isEnabled == true"
		case .isNotEnabled:
			return "isEnabled == false"
		case .isSelected:
			return "isSelected == true"
		case .isNotSelected:
			return "isSelected == false"
		}
	}
}
