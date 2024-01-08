//
//  LinkedList.swift
//
//
//  Created by ioskendev on 28.12.2023.
//

import Foundation

/// Linear twosided list.
public struct LinkedList<T: Equatable> {

	/// Two linear node.
	final class Node<N>: CustomStringConvertible {
		/// Value was stored in node.
		var value: N

		/// Link to previous Node (if previous Node is exist).
		var previous: Node<N>?

		/// Link to next Node (if next Node is exist).
		var next: Node<N>?

		/// Node CustomStringConvertible protocol realisation
		var description: String {
			"\(value)"
		}

		/// Twosided list initialisator.
		/// - Parameters:
		///   - value: Value to store in node;
		///   - next: link to next Node if next Node is exist.
		init(_ value: N, previous: Node<N>? = nil, next: Node<N>? = nil) {
			self.value = value
			self.previous = previous
			self.next = next
		}
	}

	private var head: Node<T>?
	private var tail: Node<T>?

	/// Return elements count result.
	///
	/// - Complexity: O(1).
	private(set) var count = 0

	/// Returns bool, with empty or not LinkedList meaneng.
	/// - Complexity: O(1).
	var isEmpty: Bool {
		head == nil && tail == nil
	}

	/// LinkedList init.
	/// - Parameter value: Create LinkedList with Equatable type value parameter.
	public init(value: T? = nil) {
		if let value = value {
			push(value)
		}
	}

	/// Adding to tail(beginning) of list.
	///
	/// - Complexity: O(1).
	/// - Parameter value: Equatable type value to adding to LinkedList to tail(beginning).
	public mutating func push(_ value: T) {
		let newNode = Node(value, next: head)
		head?.previous = newNode
		head = newNode

		if tail == nil { tail = head }

		count += 1
	}

	/// Adding value to head(end) of list.
	///
	/// - Complexity: O(1).
	/// - Parameter value: Value to adding to list.
	public mutating func append(_ value: T) {
		let newNode = Node(value, previous: tail)
		tail?.next = newNode
		tail = newNode

		if head == nil { head = tail }

		count += 1
	}

	/// Inserting value to middle of list.
	///
	/// - Complexity: O(n).
	/// - Parameters:
	///   - value: Value to adding to middle of list.
	///   - index: index, after wich will be inserting.
	public mutating func insert(_ value: T, after index: Int) {
		guard let currentNode = node(at: index) else { return }
		let nextNode = currentNode.next
		let newNode = Node(value, previous: currentNode, next: nextNode)
		currentNode.next = newNode
		nextNode?.previous = newNode

		if newNode.next == nil {
			tail = newNode
			}

		count += 1
	}

	/// Cut value from start of list.
	///
	/// - Complexity: O(1).
	/// - Returns: Cuting value from start of list.
	public mutating func pop() -> T? {
		guard let currentHead = head else { return nil }
		head = currentHead.next
		head?.previous = nil
		if head == nil { tail = nil }
		count -= 1
		return currentHead.value
	}

	/// Cut value from end of list.
	///
	/// - Complexity: O(1).
	/// - Returns: Cuting value from end of list.
	public mutating func removeLast() -> T? {
		guard let currentTail = tail else { return nil }
		tail = currentTail.previous
		tail?.next = nil
		if tail == nil { head = nil }

		count -= 1
		return currentTail.value
	}

	/// Cut value from middle of list after index.
	/// - Parameter index: Index, after wich will be cutting.
	/// - Returns: Cuting value from middle of list after index.
	public mutating func remove(after index: Int) -> T? {
		guard let currentNode = node(at: index), let nextNode = currentNode.next else { return nil }
		if nextNode === tail {
			tail = currentNode
			currentNode.next = nil
			} else {
				currentNode.next = nextNode.next
				nextNode.next?.previous = currentNode
			}
		count -= 1
		return nextNode.value
	}

	/// Cut value from middle of list where value is same as first of value of list.
	/// - Parameter value: Value which will be find first of value from list to cutting and return index.
	/// - Returns: if cutting is succesful returns index of cutting element.
	public mutating func remove(first value: T) -> Int? {
		guard let index = find(value: value) else { return nil }

		if index == 0 {
			_ = pop()
			return 0
		} else {
			_ = remove(after: index - 1)
			return index
		}
	}

	/// Find node from value in parameter.
	/// - Parameter element: Value to cuttring node.
	/// - Returns: Index of cutting node.
	public mutating func find(value: T) -> Int? {
		guard let head = head else { return nil }
		guard head.value != value else { return 0 }

		var currentNode = head
		var counter = 0

		while let next = currentNode.next {
			counter += 1

			guard next.value != value else { return  counter }

			currentNode = next
		}

		return nil
	}

	/// Return value from index.
	/// - Parameter index: index of target value.
	/// - Returns: Value.
	public func value(at index: Int) -> T? {
		node(at: index)?.value
	}
}

// MARK: Find Node Realization

private extension LinkedList {

	/// Return node of list from index.
	///
	/// - Complexity: O(n)
	/// - Parameter index: Index, which returns nodes element.
	/// - Returns: Node.
	func node(at index: Int) -> Node<T>? {
		guard index >= 0 && index < count else { return nil }
		var currentIndex = 0
		var currentNode: Node<T>?
		if index <= count / 2 {
			currentNode = head
			while currentIndex < index {
				currentNode = currentNode?.next
				currentIndex += 1
				}
			} else {
				currentIndex = count - 1
				currentNode = tail
				while currentIndex > index {
					currentNode = currentNode?.previous
					currentIndex -= 1
				}
			}
		return currentNode
	}
}

// MARK: Node CustomStringConvertible Realization

extension LinkedList: CustomStringConvertible {
	
	/// LinkedList CustomStringConvertible description realisation
	public var description: String {
		var values = [String]()
		var current = head

		while current != nil {
			values.append("\(current!)")
			current = current?.next
		}

		return "count = \(count); list = " + values.joined(separator: " <-> ")

	}
}
