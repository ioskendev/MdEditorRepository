//
//  ICoordinator.swift
//  MdEditor
//
//  Created by Alexey Turulin on 1/14/24.
//

protocol ICoordinator: AnyObject {
	func start()
}

class BaseCoordinator: ICoordinator {

	var childCoordinators: [ICoordinator] = []

	func start() {}

	/// Добавление зависимости (coordinator) в массив childCoordinators.
	///
	/// Добавление новой зависимости только в том случае, если такой зависимости еще нет в массиве childCoordinators.
	/// - Parameter coordinator: Зависимость, которую необходимо добавить.
	func addDependency(_ coordinator: ICoordinator) {
		// Проверяем, не содержится ли координатор уже в массиве
		guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
		// Если координатор не содержится, добавляем его в массив
		childCoordinators.append(coordinator)
	}

	/// Удаление зависимости (coordinator) из массива childCoordinators у родительского координатора.
	///
	/// Код проверяет, является ли переданный координатор подтипом BaseCoordinator и имеет ли дочерние координаторы.
	/// Если условие выполняется, то происходит рекурсивный вызов removeDependency для каждого дочернего координатора,
	///  чтобы удалить все их зависимости.
	/// - Parameter coordinator: Зависимость, которую необходимо удалить.
	func removeDependency(_ coordinator: ICoordinator) {
		// Проверяем, что массив childCoordinators не пуст
		guard !childCoordinators.isEmpty else { return }

		// Блок кода проверяет, является ли переданный координатор подтипом BaseCoordinator
		// и имеет ли дочерние координаторы. Если условие выполняется, то происходит рекурсивный
		// вызов removeDependency для каждого дочернего координатора, чтобы удалить все их зависимости.
		if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
			coordinator.childCoordinators.forEach { coordinator.removeDependency($0) }
		}

		// Этот блок кода использует метод firstIndex(where:), чтобы найти индекс первого элемента
		// в массиве childCoordinators, который удовлетворяет условию, что объект равен переданному
		// координатору ($0 === coordinator). Если индекс найден, то элемент удаляется из массива.
		if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
			childCoordinators.remove(at: index)
		}
	}
}
