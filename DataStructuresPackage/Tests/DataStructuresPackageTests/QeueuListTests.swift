//
//  File.swift
//  
//
//  Created by Alexey Turulin on 1/7/24.
//

import XCTest
@testable import DataStructuresPackage

final class QueueListTests: XCTestCase {

	// MARK: - Count Tests

	func test_count_withEmptyQueue_shouldBe0() {

		let sut = makeSUT()

		XCTAssertEqual(sut.count, 0, "Count of an empty queue should be 0.")
	}

	func test_count_withSingleEnqueuedElement_shouldBe1() {

		var sut = makeSUT()

		sut.enqueue(42)

		XCTAssertEqual(sut.count, 1, "Count should be 1 after enqueuing a single element.")
	}

	func test_count_withMultipleEnqueuedElements_shouldBeEqualToNumberOfElements() {

		var sut = makeSUT()

		sut.enqueue(42)
		sut.enqueue(43)
		sut.enqueue(44)

		XCTAssertEqual(sut.count, 3, "Count should be equal to the number of enqueued elements.")
	}

	// MARK: - IsEmpty Tests

	func test_isEmpty_withEmptyQueue_shouldBeTrue() {

		let sut = makeSUT()

		XCTAssertTrue(sut.isEmpty, "Queue without enqueued elements should be empty.")
	}

	func test_isEmpty_withSingleEnqueuedElement_shouldBeFalse() {

		var sut = makeSUT()

		sut.enqueue(42)

		XCTAssertFalse(sut.isEmpty, "Queue with enqueued element should be not empty.")
	}

	// MARK: - Enqueue Tests

	func test_enqueue_shouldReturnEnqueuedElement() {

		var sut = makeSUT()

		sut.enqueue(42)

		XCTAssertEqual(sut.peek, 42, "Peeked element should be equal to the enqueued element.")
	}

	// MARK: - Dequeue Tests

	func test_dequeue_withEmptyQueue_should() {

		var sut = makeSUT()

		XCTAssertNil(sut.dequeue(), "Dequeuing from an empty queue should return nil.")
	}

	func test_dequeue_withSingleEnqueuedElement_shouldBeTrue() {

		var sut = makeSUT()

		sut.enqueue(42)
		_ = sut.dequeue()

		XCTAssertTrue(sut.isEmpty, "Queue should be empty after dequeuing the only element.")
	}

	func test_dequeue_withSingleEnqueuedElement_shouldReturnEnqueuedElement() {

		var sut = makeSUT()

		sut.enqueue(42)

		XCTAssertEqual(sut.dequeue(), 42, "Dequeued element should be equal to the enqueued element.")
	}

	// MARK: - Peek Tests

	func test_peek_withEmptyQueue_shouldReturnNil() {

		let sut = makeSUT()

		XCTAssertNil(sut.peek, "Peek on an empty queue should return nil.")
	}

	func test_peek_withMultipleEnqueuedElements_shouldReturnFirstEnqueuedElement() {

		var sut = makeSUT()

		sut.enqueue(42)
		sut.enqueue(43)
		sut.enqueue(44)

		XCTAssertEqual(sut.peek, 42, "Peeked element should be equal the first enqueued element.")
	}
}

extension QueueListTests {
	func makeSUT() -> QueueList<Int> {
		QueueList<Int>()
	}
}
