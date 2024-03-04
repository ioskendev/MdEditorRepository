//
//  TextPreviewViewController.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/10/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit

protocol ITextPreviewViewController: AnyObject {
	func render(viewModel: TextPreviewModel.ViewModel)
}

final class TextPreviewViewController: UIViewController {
	// MARK: - Dependencies

	var interactor: ITextPreviewInteractor?

	// MARK: - Private Properties

	private var viewModel: TextPreviewModel.ViewModel! // swiftlint:disable:this implicitly_unwrapped_optional

	private lazy var textView = makeTextView(
		accessibilityIdentifier: AccessibilityIdentifier.TextPreviewScene.textView.description
	)

	private var constraints = [NSLayoutConstraint]()

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
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layout()
	}
}

// MARK: - Setup UI

private extension TextPreviewViewController {
	func setupUI() {
		view.backgroundColor = Theme.backgroundColor
		navigationController?.navigationBar.prefersLargeTitles = true

		view.addSubview(textView)
	}

	func makeTextView(accessibilityIdentifier: String) -> UITextView {
		let textView = UITextView()
		textView.font = UIFont.boldSystemFont(ofSize: 17)
		textView.textColor = Theme.mainColor
		textView.backgroundColor = Theme.backgroundColor
		textView.textAlignment = .left
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.accessibilityIdentifier = accessibilityIdentifier

		return textView
	}
}

// MARK: - Layout UI
private extension TextPreviewViewController {
	func layout() {
		NSLayoutConstraint.deactivate(constraints)

		let newConstraints = [
			textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Sizes.Padding.normal),
			textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Sizes.Padding.normal),
			textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Sizes.Padding.normal),
			textView.bottomAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.bottomAnchor,
				constant: Sizes.Padding.normal
			)
		]

		NSLayoutConstraint.activate(newConstraints)

		constraints = newConstraints
	}
}

// MARK: - IAboutViewController

extension TextPreviewViewController: ITextPreviewViewController {
	func render(viewModel: TextPreviewModel.ViewModel) {
		self.viewModel = viewModel
		title = viewModel.currentTitle
		textView.isScrollEnabled = false
		textView.attributedText = viewModel.text
		textView.isScrollEnabled = true
	}
}
