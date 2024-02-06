//
//  UIColorHexTests.swift
//  MdEditorTests
//
//  Created by ioskendev on 15.01.2024.
//

import XCTest
@testable import MdEditor

final class UIColorHexTests: XCTestCase {

	func test_init_withValidParameters_shouldBeInitSuccess() {
		let red: UInt8 = 0x26
		let green: UInt8 = 0xea
		let blue: UInt8 = 0x58
		let alpha: UInt8 = 0xff
		let expectedColor = UIColor(red: 0x26 / 255.0, green: 0xea / 255.0, blue: 0x58 / 255.0, alpha: 1)

		let sut = UIColor(red: red, green: green, blue: blue, alpha: alpha)

		XCTAssertEqual(sut, expectedColor, "Ошибка создания цвета")
	}

	func test_init_withWrongInt_shouldBeInitFailure() {
		let color = 0x987654321577
		let expectedColor = UIColor(red: 0x98 / 255.0, green: 0x76 / 255.0, blue: 0x54 / 255.0, alpha: 0x32 / 255.0)

		let sut = UIColor(hex: color)

		XCTAssertNotEqual(sut, expectedColor, "Ошибка создания цвета")
	}

	func test_init_withWrongInt_shouldBeInitSuccess() {
		let color = 0x987654321577
		let expectedColor = UIColor(red: 0x54 / 255.0, green: 0x32 / 255.0, blue: 0x15 / 255.0, alpha: 0x77 / 255.0)

		let sut = UIColor(hex: color)

		XCTAssertEqual(sut, expectedColor, "Ошибка создания цвета")
	}

	func test_init_withValidHexString_shouldBeInitSuccess() throws {
		let color = "00ff00"
		let expectedColor = UIColor(red: 0 / 255.0, green: 255 / 255.0, blue: 0 / 255.0, alpha: 1)

		let sut = UIColor(hex: color)

		XCTAssertEqual(sut, expectedColor, "Ошибка создания цвета")
	}

	func test_init_withValidHexString2_shouldBeInitSuccess() throws {
		let color = "26ea58"
		let expectedColor = UIColor(red: 38 / 255.0, green: 234 / 255.0, blue: 88 / 255.0, alpha: 1)

		let sut = UIColor(hex: color)

		XCTAssertEqual(sut, expectedColor, "Ошибка создания цвета")
	}

	func test_init_withWrongHexString_shouldBeInitFailure() throws {
		let color = "26ww58"
		let expectedColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)

		let sut = UIColor(hex: color)

		XCTAssertNotNil(sut)
		XCTAssertEqual(sut, expectedColor, "Ошибка создания цвета")
	}
}
