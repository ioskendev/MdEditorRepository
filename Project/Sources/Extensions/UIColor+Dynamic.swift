//
//  UIColor+Dynamic.swift
//  MdEditor
//
//  Created by Alexey Turulin on 1/14/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit

extension UIColor {

	/// Creates a color object that dinamically adapts to the current environment's interface style
	/// and accessibility settings.
	/// - Parameters:
	///   - light: The color to use in light mode.
	///   - dark: The color to use in dark light.
	///   - highContrastLight: The color to use in light mode with high contrast settings.
	///   - highContrastDark: The color to use in dark mode with high contrast settings.
	/// - Returns: A UIColor instance that adapts to the current interface style and accessibility settings.
	static func color(light: UIColor, dark: UIColor, highContrastLight: UIColor, highContrastDark: UIColor) -> UIColor {
		if #available(iOS 13, *) {
			return .init { traitCollection in
				let isDarkMode = traitCollection.userInterfaceStyle == .dark
				let isHighContrast = traitCollection.accessibilityContrast == .high

				switch (isDarkMode, isHighContrast) {
				case (true, false):
					return dark
				case (true, true):
					return highContrastDark
				case (false, false):
					return light
				case (false, true):
					return highContrastLight
				}
			}
		} else {
			return light
		}
	}

	/// Creates a color object that dynamically adapts to the current environment's interface style.
	/// - Parameters:
	///   - light: The color to use in light mode.
	///   - dark: The color to use in dark mode.
	/// - Returns: A UIColor instance that adapts to the current interface style.
	static func color(light: UIColor, dark: UIColor) -> UIColor {
		if #available(iOS 13, *) {
			return .init { traitCollection in
				return traitCollection.userInterfaceStyle == .dark ? dark : light
			}
		} else {
			return light
		}
	}
}
