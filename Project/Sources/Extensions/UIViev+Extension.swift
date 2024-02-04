//
//  UIViev+Extension.swift
//  MdEditor
//
//  Created by Maxim Alekseev on 03.02.2024.
//  Copyright © 2024 ioskendev. All rights reserved.
//

import UIKit

extension UIView {
	func removeAllSubviews(removeCurrentView: Bool = false) {
		if removeCurrentView {
			self.removeFromSuperview()
		} else {
			do {
				try removeSubviewRecycle(view: self)
			} catch {
				return
			}
		}
	}

	func removeSubview(view: UIView) throws {
		view.removeFromSuperview()
	}

	func removeSubviewRecycle(view: UIView) throws {
		let subviews = view.subviews
		for subview in subviews {
			do {
				try removeSubview(view: subview)
			} catch {
				return
			}
		}
	}
}
