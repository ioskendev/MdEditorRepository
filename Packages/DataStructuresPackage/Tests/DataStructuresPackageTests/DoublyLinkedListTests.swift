//
//  DoublyLinkedListTests.swift
//
//
//  Created by Alexey Turulin on 1/13/24.
//

import XCTest
@testable import DataStructuresPackage

final class DoublyLinkedListTests: XCTestCase {

	func test_init_emptyList_shouldBeEmpty() {
		let sut = DoublyLinkedList<Int>()

		XCTAssertTrue(sut.isEmpty, "Expected the list to be empty, but it is not.")
		XCTAssertEqual(sut.count, 0, "Expected the count to be 0, but found \(sut.count).")
		XCTAssertNil(sut.head, "Expected head to be nil, but it is not.")
		XCTAssertNil(sut.tail, "Expected tail to be nil, but it is not.")
	}

	func test_init_withSingleElement_shouldBeCorrect() {
		let value = 42

		let sut = DoublyLinkedList(value)

		XCTAssertFalse(sut.isEmpty, "Expected the list not to be empty, but it is.")
		XCTAssertEqual(sut.count, 1, "Expected the count to be 1, but found \(sut.count).")
		XCTAssertNotNil(sut.head, "Expected head not to be nil, but it is.")
		XCTAssertNotNil(sut.tail, "Expected tail not to be nil, but it is.")
	}

	func test_push_twoValues_shouldBeCorrectCount() {
		var sut = DoublyLinkedList<Int>()

		sut.push(42)
		sut.push(43)

		XCTAssertEqual(sut.count, 2, "Expected count to be 2, but found \(sut.count).")
	}

	func test_append_twoValues_shouldBeCorrectCount() {
		var sut = DoublyLinkedList<Int>()

		sut.append(42)
		sut.append(43)

		XCTAssertEqual(sut.count, 2, "Expected count to be 2, but found \(sut.count).")
	}

	func test_insert_shouldBeCorrect() {
		var sut = DoublyLinkedList<Int>()
		sut.append(42)
		sut.append(44)

		sut.insert(2, after: 0)

		XCTAssertEqual(sut.head?.value, 42, "Expecetd head value to be 42, but found \(sut.head?.value ?? -1).")
		XCTAssertEqual(sut.tail?.value, 44, "Expecetd tail value to be 42, but found \(sut.tail?.value ?? -1).")
		XCTAssertEqual(sut.count, 3, "Expected count to be 3, but found \(sut.count).")
	}

	func test_pop_fromListWithTwoElements_shouldBeCorrectCountAndValue() {
		var sut = DoublyLinkedList<Int>()
		sut.append(42)
		sut.append(43)

		let poppedValue = sut.pop()

		XCTAssertEqual(poppedValue, 42, "Expected popped value to be 42, but found \(poppedValue ?? -1).")
		XCTAssertEqual(sut.head?.value, 43, "Expecetd head value to be 43, but found \(sut.head?.value ?? -1).")
		XCTAssertEqual(sut.tail?.value, 43, "Expecetd tail value to be 43, but found \(sut.tail?.value ?? -1).")
		XCTAssertEqual(sut.count, 1, "Expected count to be 1, but found \(sut.count).")
	}

	func test_removeLast_fromListWithTwoElements_shouldBeCorrectCountAndValue() {
		var sut = DoublyLinkedList<Int>()
		sut.append(42)
		sut.append(43)

		let removedValue = sut.removeLast()

		XCTAssertEqual(removedValue, 43, "Expected removed value to be 43, but found \(removedValue ?? -1).")
		XCTAssertEqual(sut.head?.value, 42, "Expecetd head value to be 42, but found \(sut.head?.value ?? -1).")
		XCTAssertEqual(sut.tail?.value, 42, "Expecetd tail value to be 42, but found \(sut.tail?.value ?? -1).")
		XCTAssertEqual(sut.count, 1, "Expected count to be 1, but found \(sut.count).")
	}

	func test_removeAfter_fromListWithThreeElements_shouldBeCorrectCountAndValue() {
		var sut = DoublyLinkedList<Int>()
		sut.append(42)
		sut.append(43)
		sut.append(44)

		let removedValue = sut.remove(after: 0)

		XCTAssertEqual(removedValue, 43, "Expected removed value to be 43, but found \(removedValue ?? -1).")
		XCTAssertEqual(sut.head?.value, 42, "Expecetd head value to be 42, but found \(sut.head?.value ?? -1).")
		XCTAssertEqual(sut.tail?.value, 44, "Expecetd tail value to be 44, but found \(sut.tail?.value ?? -1).")
		XCTAssertEqual(sut.count, 2, "Expected count to be 2, but found \(sut.count).")
	}

	func test_valueAtIndex_shouldBeCorrectValues() {
		var sut = DoublyLinkedList<Int>()
		sut.append(42)
		sut.append(43)
		sut.append(44)
		sut.append(45)
		sut.append(46)

		let valueAt0 = sut.value(at: 0)
		let valueAt1 = sut.value(at: 1)
		let valueAt2 = sut.value(at: 2)
		let valueAt3 = sut.value(at: 3)
		let valueAt4 = sut.value(at: 4)
		let valueAt5 = sut.value(at: 5)

		XCTAssertEqual(valueAt0, 42, "Expected value at index 0 to be 42, but found \(valueAt0 ?? -1).")
		XCTAssertEqual(valueAt1, 43, "Expected value at index 0 to be 42, but found \(valueAt1 ?? -1).")
		XCTAssertEqual(valueAt2, 44, "Expected value at index 0 to be 42, but found \(valueAt2 ?? -1).")
		XCTAssertEqual(valueAt3, 45, "Expected value at index 0 to be 42, but found \(valueAt3 ?? -1).")
		XCTAssertEqual(valueAt4, 46, "Expected value at index 0 to be 42, but found \(valueAt4 ?? -1).")
		XCTAssertNil(valueAt5, "Expected value at index 0 to be nil, but found \(valueAt5 ?? -1).")
	}
}
