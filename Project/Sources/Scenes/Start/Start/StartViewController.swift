//
//  StartViewController.swift
//  MdEditor
//
//  Created by Maxim Alekseev on 03.02.2024.
//  Copyright © 2024 ioskendev. All rights reserved.
//

import UIKit

/// Start screen protocol
protocol IStartViewController: AnyObject {
	/// Rendering view model in view
	/// - Parameter viewModel: StartModel.ViewModel view model to render
	func render(viewModel: StartModel.ViewModel)
}

/// Start screen logic
final class StartViewController: UIViewController {

	private enum Appearence {
		static let sizeCollectionViewCell = CGSize(width: 108, height: 168)
	}

	// MARK: - Private properties

	// UI
	private lazy var collectionView = makeCollectionView()
	private lazy var buttonNewDocument = makeButtonNewDocument(
		image: Asset.Icons.doc.image, title: L10n.Start.buttonNewFile
	)
	private lazy var buttonOpenDocument = makeButtonNewDocument(
		image: Asset.Icons.folder.image, title: L10n.Start.buttonOpenFile
	)
	private lazy var buttonAbout = makeButtonAbout()

	// Other
	private var viewModel = StartModel.ViewModel(recentFiles: [])

	// MARK: - Dependecies

	var interactor: IStartInteractor?

	// MARK: - Initializers

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
		layout()
		interactor?.fetchRecentFiles()
	}
}

// MARK: - IStartViewController

extension StartViewController: IStartViewController {
	/// Rendering view model in view
	/// - Parameter viewModel: StartModel.ViewModel view model to render
	func render(viewModel: StartModel.ViewModel) {
		self.viewModel = viewModel
		collectionView.reloadData()
	}
}

// MARK: - Actions

private extension StartViewController {
	@objc
	func aboutAction() {
		interactor?.aboutAction()
	}
}

// MARK: - Setup UI

private extension StartViewController {
	func setup() {
		view.backgroundColor = Theme.backgroundColor
		title = L10n.Start.title
		navigationController?.navigationBar.prefersLargeTitles = true
	}

	func makeCollectionView() -> UICollectionView {
		let layout = UICollectionViewFlowLayout()
		layout.sectionInset = UIEdgeInsets(
			top: Sizes.Padding.half,
			left: Sizes.Padding.normal,
			bottom: Sizes.Padding.half,
			right: Sizes.Padding.normal
		)
		layout.itemSize = Appearence.sizeCollectionViewCell
		layout.scrollDirection = .horizontal
		collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(
			RecentFileCollectionViewCell.self,
			forCellWithReuseIdentifier: RecentFileCollectionViewCell.Constants.reuseId
		)
		collectionView.showsVerticalScrollIndicator = false
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = Theme.backgroundColor
		return collectionView
	}

	func makeButtonNewDocument(image: UIImage, title: String) -> UIButton {
		let button = UIButton(type: .system)

		button.configuration = .plain()
		button.configuration?.baseForegroundColor = Theme.accentColor
		button.configuration?.title = title
		button.configuration?.image = image.withTintColor(Theme.accentColor)
		button.configuration?.baseForegroundColor = Theme.accentColor
		button.configuration?.imagePadding = Sizes.Padding.half
		button.contentHorizontalAlignment = .leading
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}

	func makeButtonAbout() -> UIButton {
		let button = makeButtonNewDocument(
			image: Asset.Icons.infoBubble.image, title: L10n.Start.buttonAbout
		)
		button.addTarget(self, action: #selector(aboutAction), for: .touchUpInside)

		return button
	}
}

// MARK: - Layout

private extension StartViewController {

	func layout() {
		view.addSubview(collectionView)
		view.addSubview(buttonNewDocument)
		view.addSubview(buttonOpenDocument)
		view.addSubview(buttonAbout)
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			collectionView.heightAnchor.constraint(
				equalToConstant: Appearence.sizeCollectionViewCell.height + Sizes.Padding.normal
			),

			buttonNewDocument.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: Sizes.Padding.normal),
			buttonNewDocument.leadingAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Sizes.Padding.normal
			),
			buttonNewDocument.trailingAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Sizes.Padding.normal
			),
			buttonNewDocument.heightAnchor.constraint(equalToConstant: Sizes.M.height),

			buttonOpenDocument.topAnchor.constraint(equalTo: buttonNewDocument.bottomAnchor, constant: Sizes.Padding.half),
			buttonOpenDocument.leadingAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Sizes.Padding.normal
			),
			buttonOpenDocument.trailingAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Sizes.Padding.normal
			),
			buttonOpenDocument.heightAnchor.constraint(equalToConstant: Sizes.M.height),

			buttonAbout.topAnchor.constraint(equalTo: buttonOpenDocument.bottomAnchor, constant: Sizes.Padding.half),
			buttonAbout.leadingAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Sizes.Padding.normal
			),
			buttonAbout.trailingAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Sizes.Padding.normal
			),
			buttonAbout.heightAnchor.constraint(equalToConstant: Sizes.M.height)
		])
	}
}

// MARK: - UICollectionViewDataSource

extension StartViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.recentFiles.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: RecentFileCollectionViewCell.Constants.reuseId,
			for: indexPath
		) as? RecentFileCollectionViewCell else { return UICollectionViewCell() }
		cell.setupCell(viewModel.recentFiles[indexPath.row])
		return cell
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension StartViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		return Appearence.sizeCollectionViewCell
	}
}

// MARK: - UICollectionViewDelegate

extension StartViewController: UICollectionViewDelegate { }
