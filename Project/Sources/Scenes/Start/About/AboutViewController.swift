//
//  AboutViewController.swift
//  MdEditor
//
//  Created by ioskendev on 25.12.2023.
//

import UIKit
import WebKit

protocol IAboutViewController: AnyObject {
	func render(viewModel: AboutModel.ViewModel)
}

final class AboutViewController: UIViewController, WKNavigationDelegate {

	// MARK: - Dependencies

	var interactor: IAboutInteractor?

	// MARK: - Private properties

	private var webView = WKWebView()

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
		interactor?.show()

		webView.navigationDelegate = self
		view = webView
	}
}

// MARK: - Load page

private extension AboutViewController {
	private func loadPage(url: URL) {
		webView.load(URLRequest(url: url))
		webView.allowsBackForwardNavigationGestures = true
	}

	private func loadPage(html: String) {
		webView.loadHTMLString(html, baseURL: nil)
		webView.allowsBackForwardNavigationGestures = false
	}
}

// MARK: - IAboutViewController

extension AboutViewController: IAboutViewController {
	func render(viewModel: AboutModel.ViewModel) {
		let html = MarkdownToHtmlConverter().convert(viewModel.aboutText)
		loadPage(html: html)
	}
}
