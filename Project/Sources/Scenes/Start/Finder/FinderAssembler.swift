//
//  FinderAssembler.swift
//  MdEdit
//
//  Created by ioskendev on 12.01.2024.
//

import UIKit
import TaskManagerPackage

final class FinderAssembler {

	// MARK: - Dependencies

	private let taskManager: ITaskManager

	// MARK: - Initialization

	/// Init of FinderAssembler.
	/// - Parameters:
	///   - taskManager: Task manager.
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	// MARK: - Public methods

	/// Assemble Finder scene
	/// - Returns: FinderViewController
	func assembly() -> FinderViewController {
		let viewController = FinderViewController()
		let sectionForTaskManagerAdapter = SectionForTaskManagerAdapter(taskManager: taskManager)
		let presenter = FinderPresenter(viewController: viewController)
		let interactor = FinderInteractor(presenter: presenter, sectionManager: sectionForTaskManagerAdapter)
		viewController.interactor = interactor

		return viewController
	}
}
