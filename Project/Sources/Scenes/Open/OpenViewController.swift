//
//  OpenViewController.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/11/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit

protocol IOpenViewController {
	func render(viewModel: OpenModel.ViewModel)
}

final class OpenViewController: UITableViewController {

	// MARK: - Dependencies

	var interactor: IOpenInteractor?

	// MARK: - Private Properties

	private var viewModel = OpenModel.ViewModel(files: [])

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
		interactor?.fetchData()
	}

	// MARK: - Public Methods

	// MARK: - Delegate Implementation

	// MARK: - Private Methods
}

// MARK: - UITableView

extension OpenViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.files.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let file = viewModel.files[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		configureCell(cell, with: file)
		return cell
	}
}

// MARK: - IOpenViewController

extension OpenViewController: IOpenViewController {
	func render(viewModel: OpenModel.ViewModel) {
		self.viewModel = viewModel
		tableView.reloadData()
	}
}

// MARK: - Setup UI

private extension OpenViewController {
	func setupUI() {
		view.backgroundColor = Theme.backgroundColor
		title = L10n.Open.title
		navigationController?.navigationBar.prefersLargeTitles = true
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
	}

	func configureCell(_ cell: UITableViewCell, with file: OpenModel.ViewModel.File) {
		var content = cell.defaultContentConfiguration()
		content.text = file.name
		content.secondaryText = file.description
		content.image = UIImage(systemName: file.image)
		cell.contentConfiguration = content
		cell.backgroundColor = Theme.backgroundColor
	}
}
