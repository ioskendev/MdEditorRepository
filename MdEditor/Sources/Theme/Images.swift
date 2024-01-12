//
//  Images.swift
//  MdEdit
//
//  Created by Yuri Volegov on 12.01.2024.
//

import UIKit

enum Images {
	enum ImageSF: String {
		case list
		case chart
	}

	static func image(kind: ImageSF) -> UIImage {
		let customImage: UIImage

		switch kind {
		case .list:
			customImage = UIImage(systemName: "list.bullet") ?? .actions
		case .chart:
			customImage = UIImage(systemName: "chart.pie") ?? .actions
		}

		return customImage
	}
}
