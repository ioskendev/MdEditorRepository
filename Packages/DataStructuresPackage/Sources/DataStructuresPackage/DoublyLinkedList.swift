//
//  QueueList.swift
//
//
//  Created by Alexey Turulin on 10/30/23.
//

import Foundation

/// Represents a doubly linked list.
public struct DoublyLinkedList<T: Equatable> {

	/// Node within the doubly linked list, holding a value, previous, and next pointers.
	final class Node<N> {
		var value: N
		var previous: Node<N>?
		var next: Node<N>?

		/// Initializes a new node with a given value, and optional previous and next nodes.
		/// - Parameters:
		///   - value: The value stored in the node.
		///   - previous: An optional reference to the node’s predecessor in the list.
		///   - next: An optional reference to the node’s successor in the list.
		init(_ value: N, previous: Node<N>? = nil, next: Node<N>? = nil) {
			self.value = value
			self.next = next
			self.previous = previous
		}
	}

	private(set) var head: Node<T>?
	private(set) var tail: Node<T>?

	private(set) var count = 0

	/// Indicates whether the list is empty.
	var isEmpty: Bool {
		head == nil && tail == nil
	}

	/// Initializes a new doubly linked list, optionally with a single initial value.
	/// - Parameter value: The initial value to be contained in the list.
	public init(_ value: T? = nil) {
		if let value = value {
			let newNode = Node(value)
			head = newNode
			tail = newNode
			count = 1
		}
	}

	/// Adds a value to the beginning of the doubly linked list.
	/// - Parameter value: The value to be added at the beginning of the list.
	public mutating func push(_ value: T) {
		let newNode = Node(value, next: head)
		head?.previous = newNode
		head = newNode

		if tail == nil {
			tail = head
		}

		count += 1
	}

	/// Appends a value to the end of the doubly linked list.
	/// - Parameter value: The value to be added at the end of the list.
	public mutating func append(_ value: T) {
		let newNode = Node(value, previous: tail)

		tail?.next = newNode
		tail = newNode

		if head == nil {
			head = tail
		}

		count += 1
	}

	/// Inserts a value at a specified position in the list.
	/// - Parameters:
	///   - value: The value to insert into the list.
	///   - index: The index at which to insert the value.
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

	/// Removes and returns the first element of the list.
	/// - Returns: The value of the first element if the list is not empty; otherwise, 'nil'.
	public mutating func pop() -> T? {
		guard let currentHead = head else { return nil }
		head = currentHead.next
		head?.previous = nil

		if head == nil {
			tail = nil
		}

		count -= 1

		return currentHead.value
	}

	/// Removes and returns the last element of the list.
	/// - Returns: The value of the last element if the list is not empty; otherwise, 'nil'.
	public mutating func removeLast() -> T? {
		guard let currentTail = tail else { return nil }
		tail = currentTail.previous
		tail?.next = nil

		if tail == nil {
			head = nil
		}

		count -= 1

		return currentTail.value
	}

	/// Removes and returns an element after a specified index.
	/// - Parameter index: The index before the element to remove.
	/// - Returns: The value of the removed element if it exists and the index is valid; otherwise, 'nil'.
	public mutating func remove(after index: Int) -> T? {
		guard let currentNode = node(at: index), let nextNode = currentNode.next else { return nil }

		if currentNode.next === tail {
			tail = currentNode
			currentNode.next = nil
		} else {
			currentNode.next = nextNode.next
			nextNode.next?.previous = currentNode
		}

		count -= 1

		return nextNode.value
	}

	/// Returns the value of a node at a specified index.
	/// - Parameter index: The index of the node whose value is to be returned.
	/// - Returns: The value of the node at the given index if it exists; otherwise, 'nil'.
	public func value(at index: Int) -> T? {
		node(at: index)?.value
	}

	private func node(at index: Int) -> Node<T>? {
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
