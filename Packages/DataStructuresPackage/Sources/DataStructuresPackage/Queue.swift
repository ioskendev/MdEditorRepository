//
//  QueueList.swift
//
//
//  Created by Alexey Turulin on 10/30/23.
//

import Foundation

/// A generic queue data structure that operates on a first-in, first-out (FIFO) principle.
/// This implementation uses a doubly linked list to efficiently manage its elements.
public struct Queue<T: Equatable> {

	private var elements = DoublyLinkedList<T>()

	/// The number of elements in the queue.
	public var count: Int {
		elements.count
	}

	/// A Boolean value indicating whether the queue is empty.
	public var isEmpty: Bool {
		elements.isEmpty
	}

	/// The element at the front of the queue, if available.
	public var peek: T? {
		elements.value(at: 0)
	}

	/// Adds a new element to the end of the queue.
	/// - Parameter element: The element to add to the queue.
	public mutating func enqueue(_ element: T) {
		elements.append(element)
	}

	/// Removes and returns the element at the front of the queue, if the queue is not empty.
	/// - Returns: The element at the front of the queue, or `nil` if the queue is empty.
	public mutating func dequeue() -> T? {
		return elements.pop()
	}
}
