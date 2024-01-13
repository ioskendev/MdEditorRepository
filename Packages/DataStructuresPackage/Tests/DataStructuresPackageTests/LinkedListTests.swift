//
//  DataStructuresQueueListTests.swift
//
//
//  Created by ioskendev team on 08.01.2024.
//

import XCTest
@testable import DataStructuresPackage

final class LinkedListTests: XCTestCase {

	private enum ValuesStub: Int {
		case firstValue = 2
		case secondValue = 3
		case fhirdValue = 5
		case fouthValue = 9
	}

	private var sut: LinkedList<Int>!

	override func setUp() {
		sut = LinkedList<Int>()
	}

	override func tearDown() {
		sut = nil
	}

	/// This method do complexy checking of working count in different cases. We dont care about rawValue of appending valies, becouse we checking only count parameter of all values in LinkedList. 1) First of all we checking "is LinkedList is empty or not?" and in this case we must have count with zero returning and we do simple test of it. 2) We must checking of count parameter with non empty LinkedList and in this case we append any int value and checking equal count parameter with 1 value. 3) We checking count with more than 0 and 1 values: we append any value to list with 1 value and cheking equal of sut.count with 2 value. 4) We cheking how changes count parameter when we decrease values from list and in this case we sut.removeLast value from list with 2 values and checking equal count parameter with 1 value. 5) In last case we must return list to zero value and checking condition of count parameter and in this case we remove last value from list and do final check with sut count method and isEmpty.
	func test_count_shouldBeSameAsValuesInLinkedListInAllTests() throws {
		let newValue = ValuesStub.firstValue

		XCTAssertTrue(sut.isEmpty, "LinkedList must be empty becouse it was init with LinkedList without value: LinkedList<Int>()")
		XCTAssertEqual(sut.count, 0, "Sut count must be 0 with empty list")

		sut.append(newValue.rawValue)
		XCTAssertEqual(sut.count, 1, "Sut count must be 1 after appending 1 value")

		sut.append(newValue.rawValue)
		XCTAssertEqual(sut.count, 2, "Sut count must be 2 after appending 2 values")

		XCTAssertNotNil(sut.removeLast(), "Must return value to test sut.count")
		XCTAssertEqual(sut.count, 1, "Sut count must be 1 after removing value from 1 values in LinkedList")

		XCTAssertNotNil(sut.removeLast(), "Must return value to test sut.count")

		XCTAssertEqual(sut.count, 0, "Sut count must be 2 after appending 2 values")
		XCTAssertTrue(sut.isEmpty, "List must be empty after trying to remove from empty list")
	}

	/// This method do complexy checking of isEmpty working. All tests is cheking own sides and need to be running. First of all we check empty list after sut initialiase with none values. Second point is appending value and checking working isEmpty method with nonempty LinkedList. After all in last case we cheking how isEmpty method working after removing all values from LinkedList - isEmpty must return true (instead false in previous case with 1 value).
	func test_isEmpty_shouldBeTrueIfLinkedListWithoutValues() throws {
		let newValue = ValuesStub.firstValue

		XCTAssertTrue(sut.isEmpty, "LinkedList must be empty becouse it was init with LinkedList without value: LinkedList<Int>()")

		sut.append(newValue.rawValue)
		XCTAssertFalse(sut.isEmpty, "LinkedList can't be empty becouse we append new value to linkedList: LinkedList<Int>()")

		XCTAssertNotNil(sut.removeLast(), "Must return value to test sut.count")
		XCTAssertTrue(sut.isEmpty, "LinkedList must be empty becouse after removing value from list with 1 value")
	}

	/// This method do complexy checking of sut.push method with starting from empty list. 1) After checking sut.isEmpty(must be true - empty) we pushing first value and do some checks - list cant be empty and sut must find same value we pushing. 2. We push second value to nonempty list and push method must insert secondValue in the beginning of list at 0 index position.
	func test_push_sutShouldContainPushingValuesAndIncreaseCountValues() {
		let firstValue = ValuesStub.firstValue
		let secondValue = ValuesStub.secondValue

		XCTAssertTrue(sut.isEmpty, "LinkedList must be empty becouse it was init without value: LinkedList<Int>()")

		sut.push(firstValue.rawValue)
		XCTAssertFalse(sut.isEmpty, "LinkedList can't be empty becouse we pushing newValue: sut.push(newValue)")
		XCTAssertNotNil(sut.find(value: firstValue.rawValue), "LinkedList must contain newValue becouse we has pushed new value: sut.push(firstValue)")

		sut.push(secondValue.rawValue)
		XCTAssertEqual(sut.find(value: secondValue.rawValue), 0, "secondValue must be pushed only at the begining of list")
		XCTAssertEqual(sut.count, 2, "sut.count of values must be 2 after pushing 2 values to empty list")
	}

	/// This method do complexy checking of sut.append method with starting from empty list. 1) After checking sut.isEmpty(must be true - empty) we appending first value and do some checks - list cant be empty and sut must find same value we was appended. 2. We append second value to nonempty list and sut.append method must insert secondValue at the end of list at 0 index position.
	func test_append_sutShouldContainValues() {
		let firstValue = ValuesStub.firstValue
		let secondValue = ValuesStub.fhirdValue

		XCTAssertTrue(sut.isEmpty, "LinkedList must be empty becouse it's was init without value: LinkedList<Int>()")

		sut.append(firstValue.rawValue)

		XCTAssertFalse(sut.isEmpty, "LinkedList can't be empty becouse we appending newValue: sut.append(newValue)")

		XCTAssertNotNil(sut.find(value: firstValue.rawValue), "LinkedList must contain newValue becouse we has appended with new value: sut.append(firstValue)")

		sut.append(secondValue.rawValue)

		XCTAssertEqual(sut.find(value: secondValue.rawValue), 1, "secondValue must be append only at the end of list")
		XCTAssertEqual(sut.count, 2, "sut.count of values must be 2 after appending 2 values to empty list")
	}

	/// This method do complexy checking of sut.insert method with starting from empty list. 1.) After checking sut.isEmpty(must be true - empty) we try to insert first value after value with 0 index (it must be nil becouse no values must be found in list). 2.) We need to append or push some value to get nonempty list to continues test with inserting. 3.) We insert second value to nonempty list and sut.insert(after: 0) method must insert secondValue after firstValue rawValue. 4) We must to try insert value between 2 values to exclude append and push results.
	func test_insert_sutShouldContainValuesOnpositionsAfterInsertingTargetIndex() {
		let firstValue = ValuesStub.firstValue
		let secondValue = ValuesStub.secondValue
		let thirdValue = ValuesStub.fhirdValue

		XCTAssertTrue(sut.isEmpty, "LinkedList must be empty becouse it was init without value: LinkedList<Int>()")

		sut.insert(firstValue.rawValue, after: 0)

		XCTAssertTrue(sut.isEmpty, "LinkedList must be empty becouse it's was init without value and we can't insert value after not existing element (no index found must be found in LinkedList): LinkedList<Int>() -> sut.insert(firstValue.rawValue, after: 0) must add no values")

		sut.append(firstValue.rawValue)
		XCTAssertEqual(sut.count, 1, "sut count must be 1 after appending value")

		sut.insert(secondValue.rawValue, after: 0)
		XCTAssertEqual(sut.find(value: secondValue.rawValue), 1, "LinkedList must contain secondValue becouse we was insert secondValue after firstValue: sut.insert(thirdValue.rawValue, after: 0)")

		sut.insert(thirdValue.rawValue, after: 0)
		XCTAssertEqual(sut.find(value: thirdValue.rawValue), 1, "Third value must be inserted between firstValue and secondValue in second position with index 1")
		XCTAssertEqual(sut.count, 3, "Cheking of more then 2 elements existsut count must be 3 becouse we was apended and inserted 3 valies and sut.insert(thirdValue.rawValue, after: 0) on second position")
	}
	
	/// This method do complexy checking of sut.pop method with starting from empty list. 1) After checking sut.isEmpty(must be true - empty) we try to pop value from empty list (it must be nil becouse no values must be found in list). 2) We need to append or push some values to get nonempty list to continues test with pop (append 2 values). 3) We pop value from begin of list and result of test must be equal "firstValue" we appended first and check sut count to be 1 after removing value 4) We pop last value and check list to be empty with zero count values.
	func test_pop_sutShouldDeleteValuesFromEndOfListAndNotContainValuesAtTheEndOfTests() {
		let firstValue = ValuesStub.firstValue
		let secondValue = ValuesStub.secondValue

		XCTAssertTrue(sut.isEmpty, "LinkedList must be empty becouse it's was init without value: LinkedList<Int>()")

		XCTAssertNil(sut.pop(), "Nothing to pop from empty list")

		sut.append(firstValue.rawValue)
		sut.append(secondValue.rawValue)
		XCTAssertEqual(sut.count, 2, "sut count must be 2 after appending 2 values")

		XCTAssertEqual(sut.pop(), firstValue.rawValue, "Must cut value from start of list. pop() must returns firstValue from list, not secondValue")
		XCTAssertEqual(sut.count, 1, "sut count must be 1 after sut.pop()")

		XCTAssertEqual(sut.pop(), secondValue.rawValue, "Must cut value from start of list with 1 element. pop() must returns secondValue from list becouse we was poping firstValue in previous test")
		XCTAssertEqual(sut.count, 0, "sut count must be 0 after pop 2 values from 2 values list")

		XCTAssertTrue(sut.isEmpty, "LinkedList must be empty becouse all values was deleted from list")
	}
	
	/// This method do complexy checking of sut.removeLast method with starting from empty list. 1) After checking sut.isEmpty(must be true - empty) we try to removeLast value from empty list (it must be nil becouse nothing to remove from empty list). 2) We need to append or push some values to get nonempty list to continues test with removeLast method. 3) We call removeLast() method do remove secondValue we was appended to end of list. 4) We call removeLast() method do remove firstValue we was appended befor secondValue and do some check to be empty list.
	func test_removeLast_shuldRemoveValueFromEndOfListAndSutShouldNotContainValuesInTheEndOfTests() {
		let firstValue = ValuesStub.firstValue
		let secondValue = ValuesStub.secondValue

		XCTAssertTrue(sut.isEmpty, "LinkedList must be empty becouse it's was init without value: LinkedList<Int>()")

		XCTAssertNil(sut.removeLast(), "Nothing to remove from empty list")

		sut.append(firstValue.rawValue)
		sut.append(secondValue.rawValue)
		XCTAssertEqual(sut.count, 2, "sut count must be 2 after appending 2 values")

		XCTAssertEqual(sut.removeLast(), secondValue.rawValue, "Must cut value from end of list. removeLast() must returns secondValue from list")
		XCTAssertEqual(sut.count, 1, "sut count must be 1 after sut.removeLast()")

		XCTAssertEqual(sut.removeLast(), firstValue.rawValue, "Must cut value from end of list. pop() must returns firstValue from list")
		XCTAssertEqual(sut.count, 0, "sut count must be 0 after removing 2 values from 2 values list")

		XCTAssertTrue(sut.isEmpty, "LinkedList must be empty becouse all values was deleted from list")
	}

	/// This method do complexy checking of sut.removeAfterIndex method with starting from empty list. 1) After checking sut.isEmpty(must be true - empty) we try to sut.remove(after: 0) value from empty list (it must be nil becouse nothing to remove from empty list). 2) We need to append some values to get nonempty list to continues test with removeLast method (appending 2 values). 3) We try to remove value from index out of range. 4).
	func test_removeAfterIndex_mustRemoveValueAfteerTargetIndexAndSutShouldContainOneValueAtTheEndOfTests() {
		let firstValue = ValuesStub.firstValue
		let secondValue = ValuesStub.secondValue
		let thirdValue = ValuesStub.fhirdValue

		XCTAssertTrue(sut.isEmpty, "LinkedList must be empty becouse it's was init without value: LinkedList<Int>()")

		XCTAssertNil(sut.remove(after: 0), "Nothing to remove from empty list")

		sut.append(firstValue.rawValue)
		sut.append(secondValue.rawValue)
		sut.append(thirdValue.rawValue)

		XCTAssertEqual(sut.count, 3, "sut count must be 3 after appending 3 values")

		XCTAssertEqual(sut.remove(after: 0), secondValue.rawValue, "Must delete secondValue becouse it was append after firstValue with zero(0) index")
		XCTAssertEqual(sut.count, 2, "sut count must be 2 after removing")

		XCTAssertEqual(sut.remove(after: 0), thirdValue.rawValue, "Must delete thirdValue becouse it was append after secondValue we removing in last test")
		XCTAssertEqual(sut.count, 1, "sut count must be 1 after removing 2 values from 3 values list")

		XCTAssertNil(sut.remove(after: 0), "Must return nil, becouse after value with index 0 we was removed all values")
		XCTAssertNotEqual(sut.remove(after: -1), firstValue.rawValue, "Must nothing to delete becouse index out of list range and cant delete element after -1 index with 0 index")

		XCTAssertEqual(sut.count, 1, "sut count must stay with 1 value after trying to remove after value in onevalue list")
		XCTAssertFalse(sut.isEmpty, "LinkedList canэ't be empty becouse sut.remove(after: ) can't delete first element")
	}

	/// This method do complexy checking of sut.removeFirst finded Value as we give to find with starting from empty list. 1) After checking sut.isEmpty(must be true - empty) we try to sut.remove(first: thirdValue.rawValue value from empty list (it must be nil becouse sut.isEmpty is true). 2) We need to append some values to get nonempty list to continues test with removeLast method (appending 4 values to correct testing of serching method of sut.remove(first) method). 3) We try to remove thirdValue now where we addended thirdValue in second case of testing AND it must return 2 index of 3-th position of thirdValue AND sut.count must be 3 after removing value from 4 valueslist. 4). After all we cant to find thirdValue and cant to remove it.
	func test_removeFirstValue_sutShouldNotContainValues() {
		let firstValue = ValuesStub.firstValue
		let secondValue = ValuesStub.secondValue
		let thirdValue = ValuesStub.fhirdValue
		let fouthValue = ValuesStub.fouthValue
		
		XCTAssertTrue(sut.isEmpty, "LinkedList must be empty becouse it's was init without value: LinkedList<Int>()")
		
		XCTAssertNil(sut.remove(first: thirdValue.rawValue), "Nothing to remove from empty list")
		
		sut.append(firstValue.rawValue)
		sut.append(secondValue.rawValue)
		sut.append(thirdValue.rawValue)
		sut.append(fouthValue.rawValue)

		XCTAssertEqual(sut.remove(first: thirdValue.rawValue), 2, "Must delete thirdValue with 2 index")
		XCTAssertEqual(sut.count, 3, "sut count must be 3 after removing 1 value from list of 4 values")
		XCTAssertNotEqual(sut.find(value: thirdValue.rawValue), thirdValue.rawValue, "sut count must be 1 after removing")
		XCTAssertNil(sut.remove(first: thirdValue.rawValue), "Must be nil becouse we removing it in previous test")
	}

	/// This method do complexy checking of sut.value from index with starting from empty list. 1) After checking sut.isEmpty(must be true - empty) we try to find any value with must be nil result. 2) We need to append some values to get nonempty list to continues test (appending 4 values to correct testing of serching method of sut.remove(first) method). 3) After adding values we try to find at same index 2 where we must find thirdValue.
	func test_value_sutShouldContainsTargetValueAfterAppending() {
		let firstValue = ValuesStub.firstValue
		let secondValue = ValuesStub.secondValue
		let thirdValue = ValuesStub.fhirdValue
		let fouthValue = ValuesStub.fouthValue

		XCTAssertTrue(sut.isEmpty, "LinkedList must be empty becouse it's was init without value: LinkedList<Int>()")

		XCTAssertNil(sut.value(at: 2), "must be nil becouse nothing to find in empty list")

		sut.append(firstValue.rawValue)
		sut.append(secondValue.rawValue)
		sut.append(thirdValue.rawValue)
		sut.append(fouthValue.rawValue)

		XCTAssertEqual(sut.value(at: 2), thirdValue.rawValue, "sut.value(at: 2) must return thirdValue becouse it was appended 3th at line")
	}
}
