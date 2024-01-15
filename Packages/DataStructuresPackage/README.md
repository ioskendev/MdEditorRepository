# DoublyLinkedListQueue

This Swift package provides a generic implementation of a doubly linked list and a queue data structure. These data structures are efficient and flexible, ideal for various applications.

## Overview

The package provides two main structures:

- **DoublyLinkedList**: A sequence of elements where each element points to the previous and next element, providing O(1) time complexity for adding and removing elements from both ends of the list.
- **Queue**: A classic FIFO (first in, first out) data structure using the included DoublyLinkedList to allow constant time enqueues and dequeues.

These structures are implemented in a generic way, allowing use with any data type that conforms to the `Equatable` protocol.

There is a DoublyLinkedList class (though its implementation is not shown) that provides functionalities like count, isEmpty, value(at:), append(_:) and pop(). The node(at:) function is a method for this class. The Queue struct uses the DoublyLinkedList to implement a queue data structure. 

Here is a brief summary of what each method does, assuming other necessary parts of the DoublyLinkedList are implemented correctly:

- node(at index: Int) -> Node<T>?: Returns a node at a specific index in the list. If the index is in the first half of the list, it starts from the head and traverses forward. If the index is in the second half, it starts from the tail and traverses backward. This helps in reducing the time to traverse for nodes located towards the end of the list.

- count: Gets the number of elements in the linked list or the queue.

- isEmpty: Returns a Boolean value indicating whether the linked list or the queue is empty.

- peek: Allows seeing the first element of the queue without removing it.

- enqueue(_:): Adds a new element at the end of the queue.

- dequeue() -> T?: Removes and returns the first element of the queue.

Here is what you should consider adding to the doubly linked list implementation:

- Definition for the Node class including properties next and previous which are optional references to the next and previous nodes in the list.
- DoublyLinkedList class basic properties such as head and tail.
- DoublyLinkedList class methods like pop() to remove the first element, append(_:) to add an element to the end of the list, and isEmpty to check if the list has no elements.
- Implement additional methods or properties if they are referenced in the provided code (such as value(at:) if it's not an alias for node(at:)).

For a complete and functional data structure implementation, you'll need to ensure the full DoublyLinkedList class is provided, including initializers, and properly connect the queue functions to work with it.

## Architecture

The `DoublyLinkedList` is based on nodes linked to each previous and next node, allowing for bidirectional traversal. Here are the core components:

- `Node`: A class representing a single node in the list.
- `DoublyLinkedList`: A struct managing nodes to form a list, providing methods for common list operations.

This library also features a simple `Queue` implementation using `DoublyLinkedList` to manage its elements efficiently.

## Features

- Easy to use API for managing linked lists and queues.
- Generic implementation for use with any `Equatable` types.
- Methods for adding, removing, and accessing elements.
- Optimal performance characteristics for typical list and queue operations.

## Getting Started

### Requirements

- Swift 5 or higher
- Xcode 11 or higher (if using IDE)
- Swift Package Manager (SPM) for dependency management

### Installation

To use the DoublyLinkedListQueue in your project, add the following as a dependency to your `Package.swift` file:

swift
dependencies: 
    .package(url: "https://github.com/yourusername/DoublyLinkedListQueue.git", from: "1.0.0")


Then, simply import the module in your Swift files to use it:

swift
import DoublyLinkedListQueue


To provide a complete package, remember to implement and add the missing `Queue` structure to your library. Make sure your Swift package includes clear public API documentation for users to understand how to interact with `DoublyLinkedList` and `Queue`. Update the README's repository URL and the version tag as appropriate for your package.

---

For issues, suggestions, or contributions, feel free to open an issue or pull request in the repository.


