//
//  AboutViewController.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/10/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit
import WebKit

protocol IAboutViewController: AnyObject {
	func render(viewModel: AboutModel.ViewModel)
}

final class AboutViewController: UIViewController {
	// MARK: - Dependencies

	var interactor: IAboutInteractor?

	// MARK: - Private Properties

	private let webView = WKWebView()

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

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		if self.isMovingFromParent {
			interactor?.backButtonPressed()
		}
	}

	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		webView.underPageBackgroundColor = Theme.backgroundColor
		interactor?.fetchData()
	}
}

// MARK: - IAboutViewController

extension AboutViewController: IAboutViewController {
	func render(viewModel: AboutModel.ViewModel) {
		webView.loadHTMLString(viewModel.html, baseURL: nil)
	}
}

// MARK: - Setup UI

private extension AboutViewController {
	func setupUI() {
		navigationController?.navigationBar.tintColor = Theme.black

		webView.underPageBackgroundColor = Theme.backgroundColor

		view = webView
		title = L10n.About.title
		navigationController?.navigationBar.prefersLargeTitles = true
	}
}
