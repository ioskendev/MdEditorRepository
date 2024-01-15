//
//  QeueuTests.swift
//
//
//  Created by Alexey Turulin on 1/7/24.
//

import XCTest
@testable import DataStructuresPackage

final class QueueTests: XCTestCase {

	func test_init_emptyQueue_shouldBeEmpty() {
		let sut = makeSUT()

		XCTAssertTrue(sut.isEmpty, "Expected the queue to be empty, but it's not.")
		XCTAssertEqual(sut.count, 0, "`expected the queue count to be 0, but found \(sut.count).")
		XCTAssertNil(sut.peek, "Expected the peek value to be nil in an empty queue.")
	}

	func test_enqueue_twoValues_shouldBeCorrectCountAndFirstValue() {
		var sut = makeSUT()

		sut.enqueue(42)
		sut.enqueue(43)

		XCTAssertEqual(sut.count, 2, "Expected the queue count to be 2, but found \(sut.count).")
		XCTAssertEqual(sut.peek, 42, "Expected the first value in the queue to be 42, but found \(sut.peek ?? -1).")
	}

	func test_dequeue_onTwoValues_shouldBeCorrectCountAndFirstValue() {
		var sut = makeSUT()
		sut.enqueue(42)
		sut.enqueue(43)

		let dequeuedValue = sut.dequeue()

		XCTAssertEqual(dequeuedValue, 42, "Expected the dequeued value to be 42, but found \(dequeuedValue ?? -1).")
		XCTAssertEqual(sut.count, 1, "Expected the queue count to be 1 after dequeuing, but found \(sut.count).")
		XCTAssertEqual(sut.peek, 43, "Expected the new peek value to be 43, but found \(sut.peek ?? -1).")
	}

	func test_doubleDequeue_onTwoValues_shouldBeCorrectCountAndFirstValue() {
		var sut = makeSUT()
		sut.enqueue(42)
		sut.enqueue(43)

		_ = sut.dequeue()
		let seconddequeuedValue = sut.dequeue()

		XCTAssertEqual(
			seconddequeuedValue,
			43,
			"Expected the second dequeued value to be 43, but found \(seconddequeuedValue ?? -1)."
		)
		XCTAssertTrue(sut.isEmpty, "Expected the queue to be empty after double dequeue, but it's not.")
		XCTAssertEqual(sut.count, 0, "Expected the queue count to be 0 after double dequeue, but found \(sut.count).")
		XCTAssertNil(sut.peek, "Expected the peek value to be nil in an empty queue after double dequeue.")
	}

	func test_peek_onTwoValues_shouldBeCorrectCountAndFirstValue() {
		var sut = makeSUT()
		sut.enqueue(42)
		sut.enqueue(43)

		let peekedValue1 = sut.peek
		_ = sut.dequeue()
		let peekedValue2 = sut.peek

		XCTAssertEqual(peekedValue1, 42, "Expected the first peeked value to be 42, but found \(peekedValue1 ?? -1).")
		XCTAssertEqual(peekedValue2, 43, "Expected the second peeked value to be 43, but found \(peekedValue2 ?? -1).")
		XCTAssertEqual(sut.count, 1, "Expected the queue count to be 1 after peeking, but found \(sut.count).")
	}
}

extension QueueTests {
	func makeSUT() -> Queue<Int> {
		Queue<Int>()
	}
}
