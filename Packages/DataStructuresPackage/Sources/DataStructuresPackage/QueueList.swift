//
//  QueueList.swift
//
//
//  Created by ioskendev on 28.12.2023.
//

import Foundation

public struct QueueList<T: Equatable> {

	private var linkedList = LinkedList<T>()
	
	/// The count of the queue list.
	public var count: Int {
		linkedList.count
	}

	/// The empty status of the queue list as a Bool value.
	/// - Returns: True if the list is empty and False if is not.
	public var isEmpty: Bool {
		linkedList.isEmpty
	}
	
	/// Appending a value to the end of the queue list.
	/// - Parameter value: An Equatable value to append to the  linked list.
	public mutating func enqueue(_ element: T) {
		linkedList.append(element)
	}
	
	/// Removing a value from the beginning of the list.
	/// - Returns: The removed value.
	public mutating func dequeue() -> T? {
		linkedList.pop()
	}
	
	/// Peeking a value from the beginning of the list.
	/// - Returns: The first value from the queue list.
	public var peek: T? {
		linkedList.value(at: 0)
	}
}
