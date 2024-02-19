//
//  FileTableViewCell.swift
//  MdEditor
//
//  Created by Alexey Turulin on 2/17/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit

final class FileTableViewCell: UITableViewCell {

	static let reusableIdentifier = "FileTableViewCell"

	// MARK: - Private properties

	private lazy var imageViewIcon = makeImageViewIcon()
	private lazy var labelTitle = makeLabelTitle()
	private lazy var labelSubtitle = makeLabelSubtitle()

	// MARK: - Initialization

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
		layout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public methods

	func configure(title: String, subtitle: String, icon: UIImage) {
		imageViewIcon.image = icon
		labelTitle.text = title
		labelSubtitle.text = subtitle
	}
}

// MARK: - Setup UI

private extension FileTableViewCell {

	func setupUI() {
		backgroundColor = Theme.backgroundColor
	}

	func makeImageViewIcon() -> UIImageView {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleToFill
		return imageView
	}

	func makeLabelTitle() -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 17)
		label.textColor = Theme.mainColor
		label.textAlignment = .left
		return label
	}

	func makeLabelSubtitle() -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 12)
		label.textColor = Theme.mainColor
		label.textAlignment = .right
		return label
	}
}

// MARK: - Layout UI

private extension FileTableViewCell {
	func layout() {

		addSubview(imageViewIcon)
		addSubview(labelTitle)
		addSubview(labelSubtitle)

		NSLayoutConstraint.activate([
			imageViewIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.Padding.normal),
			imageViewIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
			imageViewIcon.widthAnchor.constraint(equalToConstant: Sizes.L.icon),
			imageViewIcon.heightAnchor.constraint(equalToConstant: Sizes.L.icon),

			labelTitle.leadingAnchor.constraint(equalTo: imageViewIcon.trailingAnchor, constant: Sizes.Padding.normal),
			labelTitle.topAnchor.constraint(equalTo: topAnchor, constant: Sizes.Padding.micro),

			labelSubtitle.leadingAnchor.constraint(equalTo: imageViewIcon.trailingAnchor, constant: Sizes.Padding.normal),
			labelSubtitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Sizes.Padding.micro),
			labelSubtitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Sizes.Padding.normal)
		])
	}
}
