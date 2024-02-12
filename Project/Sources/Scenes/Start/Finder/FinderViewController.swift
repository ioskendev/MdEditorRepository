//
//  FinderViewController.swift
//  MdEdit
//
//  Created by ioskendev on 12.01.2024.
//

import UIKit

/// Finder screen.
protocol IFinderViewController: AnyObject {

	/// Method to render information on the screen.
	/// - Parameter viewModel: viewModel with data to render.
	func render(viewModel: FinderModel.ViewModel)
}

/// Finder screen logic
final class FinderViewController: UITableViewController {

	// MARK: - Dependencies

	var interactor: IFinderInteractor?

	// MARK: - Private properties

	private var viewModel = FinderModel.ViewModel(tasksBySections: [])

	// MARK: - Initialization

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		interactor?.fetchData()
	}
}

// MARK: - UITableView

extension FinderViewController {

	override func numberOfSections(in tableView: UITableView) -> Int {
		viewModel.tasksBySections.count
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		let sectionView = tableView.headerView(forSection: section)
		sectionView?.accessibilityIdentifier = AccessibilityIdentifier.FinderScene.section(section).description

		return viewModel.tasksBySections[section].title
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let section = viewModel.tasksBySections[section]
		return section.tasks.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let task = getTaskForIndex(indexPath)
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		configureCell(cell, with: task)

		cell.accessibilityIdentifier = AccessibilityIdentifier.FinderScene.cell(
			section: indexPath.section,
			row: indexPath.row
		).description

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor?.didTaskSelected(request: FinderModel.Request.TaskSelected(indexPath: indexPath))
	}
}

// MARK: - UI setup

private extension FinderViewController {

	private func setupUI() {
		view.backgroundColor = Theme.backgroundColor
		title = L10n.Finder.title
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.hidesBackButton = true

		tableView.accessibilityIdentifier = AccessibilityIdentifier.FinderScene.table.description
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
	}

	func getTaskForIndex(_ indexPath: IndexPath) -> FinderModel.ViewModel.Task {
		let tasks = viewModel.tasksBySections[indexPath.section].tasks
		let task = tasks[indexPath.row]
		return task
	}

	func configureCell(_ cell: UITableViewCell, with task: FinderModel.ViewModel.Task) {
		var contentConfiguration = cell.defaultContentConfiguration()

		cell.tintColor = Theme.accentColor
		cell.backgroundColor = Theme.backgroundColor
		cell.selectionStyle = .none

		switch task {
		case .importantTask(let task):
			let redText = [NSAttributedString.Key.foregroundColor: Theme.accentColor]
			let taskText = NSMutableAttributedString(string: task.priority + " ", attributes: redText )
			taskText.append(NSAttributedString(string: task.title))

			contentConfiguration.attributedText = taskText
			contentConfiguration.secondaryText = task.deadLine
			cell.accessoryType = task.completed ? .checkmark : .none
		case .regularTask(let task):
			contentConfiguration.text = task.title
			cell.accessoryType = task.completed ? .checkmark : .none
		}

		cell.contentConfiguration = contentConfiguration
	}
}

// MARK: - IMainViewController

extension FinderViewController: IFinderViewController {

	/// Render FinderModel data model.
	/// - Parameter viewModel: FinderModel data.
	func render(viewModel: FinderModel.ViewModel) {
		self.viewModel = viewModel
		tableView.reloadData()
	}
}
