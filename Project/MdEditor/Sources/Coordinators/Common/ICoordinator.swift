//
//  ICoordinator.swift
//  MdEdit
//
//  Created by ioskendev on 12.01.2024.
//

protocol ICoordinator: AnyObject {
	func start()
}

class BaseCoordinator: ICoordinator {

	var childCoordinators: [ICoordinator] = []

	func start() {}

	/// Add dependency (coordinator) in array childCoordinators.
	///
	/// Adding new dependency where depency is not contained in  childCoordinator
	/// - Parameter coordinator: Dependency to adding.
	func addDependency(_ coordinator: ICoordinator) {
		// Checking: is array contains coordinator or not
		guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
		// if coordinator not contains, then add it to array
		childCoordinators.append(coordinator)
	}

	/// Remove dependency (coordinator) from array childCoordinators from parant coordinator.
	/// It is checking, is coordinator nested from BaseCoordinator and is it have child coordinators or not.
	/// If it is true, than recycle calling removeDependency method for each child coordinator
	/// to delete all dependencies.
	/// - Parameter coordinator: Dependency, to deletion.
	func removeDependency(_ coordinator: ICoordinator) {
		// cheking array childCoordinators is empty
		guard !childCoordinators.isEmpty else { return }

		// It is checking, is coordinator nested from BaseCoordinator and is it have child coordinators or not.
		// If it is true, than recycle calling removeDependency method for each child coordinator
		// to delete all dependencies.
		if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
			coordinator.childCoordinators.forEach { coordinator.removeDependency($0) }
		}

		// Calling firstIndex(where:), to find first element index
		// in array childCoordinaters, where element is same as first element in array
		// coordinator ($0 = coordinator). If index find, then element is deleting from array.
		if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
			childCoordinators.remove(at: index)
		}
	}
}
