//
//  UIViewController+Preview.swift
//  MdEditor
//
//  Created by ioskendev on 12.01.2024.
//

import SwiftUI

extension UIViewController {

	/// A struct that conforms to 'UIViewControllerRepresentable' for SwiftUI previews.
	struct Preview: UIViewControllerRepresentable {

		/// The view controller to be previewed.
		let viewController: UIViewController

		/// Creates the view controller object and configures its initial state.
		/// - Parameter context: A context structure containing information about the current state of the system.
		/// - Returns: A 'UIViewController' instance to be previewed.
		func makeUIViewController(context: Context) -> some UIViewController {
			viewController
		}

		/// Updates the state of the specified view controller with new information from SwiftUI.
		/// - Parameters:
		///   - uiViewController: The UIKit view controller object.
		///   - context: A context structure containing information about the current state of the system.
		func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
	}

	/// Creates a SwiftUI view that previews this view controller.
	/// - Returns: A SwiftUI view that previews this view controller.
	func preview() -> some View {
		Preview(viewController: self).edgesIgnoringSafeArea(.all)
	}
}
