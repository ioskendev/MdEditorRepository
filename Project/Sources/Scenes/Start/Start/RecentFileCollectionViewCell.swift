//
//  RecentFileCollectionViewCell.swift
//  MdEditor
//
//  Created by Maxim Alekseev on 03.02.2024.
//  Copyright © 2024 ioskendev. All rights reserved.
//

import UIKit

final class RecentFileCollectionViewCell: UICollectionViewCell {

	enum Constants {
		static let reuseId = String(describing: RecentFileCollectionViewCell.self)
		static let sizeFontFileName: CGFloat = 10
		static let heightLabelFileName: CGFloat = 12
	}

	// MARK: - Lifecycle

	override func prepareForReuse() {
		super.prepareForReuse()
		removeAllSubviews()
	}
}

// MARK: - Public methods

extension RecentFileCollectionViewCell {

	/// Setup RecentFileCollectionViewCell
	/// - Parameter recentFile: IRecentFile recent file model
	func setupCell(_ recentFile: IRecentFile) {
		setupViewFileThumbPreview(contentType: recentFile.contentType)
		setupLabel(fileName: recentFile.name)
	}
}

// MARK: - Private methods

private extension RecentFileCollectionViewCell {
	private func setupLabel(fileName: String) {
		let labelFileName = UILabel()
		labelFileName.text = fileName
		labelFileName.font = .systemFont(ofSize: Constants.sizeFontFileName)
		labelFileName.textAlignment = .center
		labelFileName.frame.origin = CGPoint(x: .zero, y: bounds.height - Constants.heightLabelFileName)
		labelFileName.frame.size = CGSize(width: bounds.width, height: Constants.heightLabelFileName)
		addSubview(labelFileName)
	}

	func setupViewFileThumbPreview(contentType: FileContentType) {
		let viewFileThumbPreview = UIView()
		viewFileThumbPreview.frame = CGRect(
			x: .zero,
			y: .zero,
			width: bounds.width,
			height: bounds.height - Constants.heightLabelFileName
		)
		viewFileThumbPreview.layer.cornerRadius = Sizes.cornerRadius
		switch contentType {

		case .usual:
			viewFileThumbPreview.backgroundColor = Theme.green
		case .richText:
			viewFileThumbPreview.backgroundColor = Theme.orange
		}
		addSubview(viewFileThumbPreview)
	}
}
