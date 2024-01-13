//
//  File.swift
//  
//
//  Created by Alexey Turulin on 1/6/24.
//

import XCTest
@testable import DataStructuresPackage

final class NodeTests: XCTestCase {

	// MARK: - Init Tests

	func test_init_withValue_shouldReturnNodeWithCorrectValue() {

		let sut = LinkedList<Int>.Node(42)

		XCTAssertEqual(sut.value, 42, "A Node should be initialized with the correct value.")
	}

	func test_init_withValue_shouldBeNilPreviousNode() {

		let sut = LinkedList<Int>.Node(42)

		XCTAssertNil(sut.previous, "A Node initialized with only a value should have its previous node set to nil")
	}

	func test_init_withValue_shouldBeNilNextNode() {

		let sut = LinkedList<Int>.Node(42)

		XCTAssertNil(sut.next, "A Node initialized with the only a value should have its next node set to nil.")
	}

	func test_init_withValueAndPreviousNode_shouldReturnPreviousNodeWithCorrectValue() {

		let previousNode = LinkedList<Int>.Node(41)

		let sut = LinkedList<Int>.Node(42, previous: previousNode)

		XCTAssertEqual(sut.previous?.value, 41, "Previous node should have the correct value.")
	}

	func test_init_withValueAndNextNode_shouldReturnNextNodeWithCorrectValue() {

		let nextNode = LinkedList<Int>.Node(43)

		let sut = LinkedList<Int>.Node(42, next: nextNode)

		XCTAssertEqual(sut.next?.value, 43, "Next node should have the correct value.")
	}

	// MARK: - Description Tests

	func test_description_withValue_shouldReturnStringWithCorrectValue() {

		let sut = LinkedList<Int>.Node(42)

		XCTAssertEqual(sut.description, "42", "The description should return a string with the correct value.")
	}
}
