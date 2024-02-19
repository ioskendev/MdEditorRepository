//
//  RecentFileCollectionViewCell.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/18/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit

final class RecentFileCollectionViewCell: UICollectionViewCell {

	static let reusableIdentifier = "RecentFileCollectionViewCell"

	// MARK: - Private properties

	private lazy var viewCover = makeColoredView()
	private lazy var labelPreviewText = makeMultilineLabel()
	private lazy var labelTitle = makeCenterAlignedLabel()

	private let viewCoverHeight: CGFloat = 140
	private let viewCoverWidth: CGFloat = 90

	// MARK: - Initialization

	override init(frame: CGRect) {
		super.init(frame: frame)
		layout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public methods

	func configure(fileName: String, previewText: String) {
		viewCover.backgroundColor = textToColor(previewText)
		labelPreviewText.text = previewText
		labelTitle.text = fileName
	}
}

private extension RecentFileCollectionViewCell {
	func textToColor(_ text: String) -> UIColor {
		let colors = [
			Colors.red,
			Colors.orange,
			Colors.green,
			Colors.blue,
			Colors.violet
		]

		return colors[text.count % 5]
	}
}

// MARK: - Setup UI

private extension RecentFileCollectionViewCell {
	func makeColoredView() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}

	func makeMultilineLabel() -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Theme.backgroundColor
		label.font = UIFont.systemFont(ofSize: 10)
		label.numberOfLines = 0
		return label
	}

	func makeCenterAlignedLabel() -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Theme.mainColor
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 10)
		return label
	}
}

// MARK: - Layout UI
private extension RecentFileCollectionViewCell {
	func layout() {
		addSubview(viewCover)
		viewCover.addSubview(labelPreviewText)
		addSubview(labelTitle)

		NSLayoutConstraint.activate([
			viewCover.topAnchor.constraint(equalTo: topAnchor, constant: Sizes.Padding.normal),
			viewCover.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.Padding.normal),
			viewCover.heightAnchor.constraint(equalToConstant: viewCoverHeight),
			viewCover.widthAnchor.constraint(equalToConstant: viewCoverWidth),

			labelPreviewText.leadingAnchor.constraint(equalTo: viewCover.leadingAnchor, constant: Sizes.Padding.small),
			labelPreviewText.trailingAnchor.constraint(equalTo: viewCover.trailingAnchor, constant: -Sizes.Padding.small),
			labelPreviewText.topAnchor.constraint(equalTo: viewCover.topAnchor, constant: Sizes.Padding.small),
			labelPreviewText.bottomAnchor.constraint(equalTo: viewCover.bottomAnchor, constant: -Sizes.Padding.small),

			labelTitle.topAnchor.constraint(equalTo: viewCover.bottomAnchor, constant: Sizes.Padding.normal),
			labelTitle.leadingAnchor.constraint(equalTo: viewCover.leadingAnchor),
			labelTitle.trailingAnchor.constraint(equalTo: viewCover.trailingAnchor)
		])
	}
}
