//
//  TodoListViewController.swift
//  MdEditor
//
//  Created by Alexey Turulin on 11/28/23.
//

import SwiftUI
import TaskManagerPackage

/// Протокол главного экрана приложения.
protocol ITodoListViewController: AnyObject {

	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewModel: TodoListModel.ViewModel)
}

/// Главный экран приложения.
final class TodoListViewController: UITableViewController {

	// MARK: - Dependencies

	var interactor: ITodoListInteractor?

	// MARK: - Private properties

	private var viewModel = TodoListModel.ViewModel(tasksBySections: [])

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

extension TodoListViewController {

	override func numberOfSections(in tableView: UITableView) -> Int {
		viewModel.tasksBySections.count
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		let sectionView = tableView.headerView(forSection: section)
		sectionView?.accessibilityIdentifier = AccessibilityIdentifier.TodoListScene.section(section).description

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

		cell.accessibilityIdentifier = AccessibilityIdentifier.TodoListScene.cell(
			section: indexPath.section,
			row: indexPath.row
		).description

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor?.didTaskSelected(request: TodoListModel.Request.TaskSelected(indexPath: indexPath))
	}
}

// MARK: - UI setup

private extension TodoListViewController {

	func setupUI() {
		view.backgroundColor = Theme.backgroundColor
		title = L10n.TodoList.title
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.hidesBackButton = true

		tableView.accessibilityIdentifier = AccessibilityIdentifier.TodoListScene.table.description
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
	}

	func getTaskForIndex(_ indexPath: IndexPath) -> TodoListModel.ViewModel.Task {
		let tasks = viewModel.tasksBySections[indexPath.section].tasks
		let task = tasks[indexPath.row]
		return task
	}

	func configureCell(_ cell: UITableViewCell, with task: TodoListModel.ViewModel.Task) {
		var contentConfiguration = cell.defaultContentConfiguration()

		cell.tintColor = Theme.accentColor
		cell.backgroundColor = Theme.backgroundColor
		cell.selectionStyle = .none

		switch task {
		case .importantTask(let task):
			let redText = [NSAttributedString.Key.foregroundColor: Theme.accentColor]
			let taskText = NSMutableAttributedString(string: task.priority + " ", attributes: redText)
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

extension TodoListViewController: ITodoListViewController {

	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewModel: TodoListModel.ViewModel) {
		self.viewModel = viewModel
		tableView.reloadData()
	}
}

// MARK: - Preview

struct TodoListViewControllerProvider: PreviewProvider {
	static var previews: some View {
		TodoListAssembler(
			taskManager: TaskManager(
				taskList: TaskRepositoryStub().getTasks()
			)
		).assembly(createTaskClosure: nil).preview()
	}
}
