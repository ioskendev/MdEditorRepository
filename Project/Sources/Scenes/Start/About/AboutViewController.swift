//
//  AboutViewController.swift
//  MdEditor
//
//  Created by ioskendev on 25.12.2023.
//

import UIKit

protocol IAboutViewController: AnyObject {
	func render(viewModel: AboutModel.ViewModel)
}

final class AboutViewController: UIViewController {

	// MARK: - Dependencies

	var interactor: IAboutInteractor?

	// MARK: - Private properties

	private lazy var textViewAbout: UITextView = makeTextView()

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
		setupUI()
		interactor?.show()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layout()
	}
}

// MARK: - Setup UI

private extension AboutViewController {

	func makeTextView() -> UITextView {
		let textView = UITextView()

		textView.translatesAutoresizingMaskIntoConstraints = false

		return textView
	}

	func setupUI() {
		view.backgroundColor = .white
		title = "About"
		navigationController?.navigationBar.prefersLargeTitles = true

		view.addSubview(textViewAbout)
	}
}

// MARK: - Layout UI

private extension AboutViewController {

	func layout() {
		NSLayoutConstraint.deactivate(constraints)

		let newConstraints = [
			textViewAbout.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			textViewAbout.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
			textViewAbout.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
			textViewAbout.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		]

		NSLayoutConstraint.activate(newConstraints)

		constraints = newConstraints
	}
}

// MARK: - IAboutViewController

extension AboutViewController: IAboutViewController {
	func render(viewModel: AboutModel.ViewModel) {
		textViewAbout.text = viewModel.aboutText
	}
}
