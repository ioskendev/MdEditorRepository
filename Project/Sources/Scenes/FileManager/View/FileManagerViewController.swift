//
//  FileManagerViewController.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/11/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit

protocol IFileManagerViewController {
	func render(viewModel: FileManagerModel.ViewModel)
}

final class FileManagerViewController: UIViewController {

	// MARK: - Dependencies

	var interactor: IFileManagerInteractor?

	// MARK: - Private Properties

	private lazy var tableView: UITableView = makeTableView(
		accessibilityIdentifier: AccessibilityIdentifier.FileManagerScene.menu.description
	)

	private lazy var folderImage = makeFolderImage()
	private lazy var fileImage = makeFileImage()

	private var viewModel: FileManagerModel.ViewModel! // swiftlint:disable:this implicitly_unwrapped_optional

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
		interactor?.fetchData()
		setupUI()
		layout()
	}
}

// MARK: - Setup UI

private extension FileManagerViewController {
	func setupUI() {
		view.backgroundColor = Theme.backgroundColor
		navigationController?.navigationBar.prefersLargeTitles = true

		view.addSubview(tableView)
		tableView.register(FileTableViewCell.self, forCellReuseIdentifier: FileTableViewCell.reusableIdentifier)
	}

	func makeTableView(accessibilityIdentifier: String) -> UITableView {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.backgroundColor = Theme.backgroundColor

		tableView.delegate = self
		tableView.dataSource = self
		return tableView
	}

	func makeFolderImage() -> UIImage {
		UIImage(systemName: "folder.fill")?.withTintColor(
			Theme.mainColor,
			renderingMode: .alwaysOriginal
		) ?? UIImage()
	}

	func makeFileImage() -> UIImage {
		UIImage(systemName: "doc.fill")?.withTintColor(
			Theme.mainColor,
			renderingMode: .alwaysOriginal
		) ?? UIImage()
	}
}

// MARK: - Layout UI

private extension FileManagerViewController {
	func layout() {
		NSLayoutConstraint.activate(
			[
				tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
				tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
				tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
				tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
			]
		)
	}
}

// MARK: - UITableViewDelegate

extension FileManagerViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.files.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(
			withIdentifier: FileTableViewCell.reusableIdentifier,
			for: indexPath
		) as! FileTableViewCell // swiftlint:disable:this force_cast

		let file = viewModel.files[indexPath.row]

		switch file.isFolder {
		case true:
			cell.configure(title: file.name, subtitle: file.info, icon: folderImage)
		case false:
			cell.configure(title: file.name, subtitle: file.info, icon: fileImage)
		}

		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor?.performAction(request: .fileSelected(indexPath: indexPath))
	}
}

// MARK: - IFileManagerViewController

extension FileManagerViewController: IFileManagerViewController {
	func render(viewModel: FileManagerModel.ViewModel) {
		self.viewModel = viewModel
		title = viewModel.currentFolderName
		tableView.reloadData()
	}
}
