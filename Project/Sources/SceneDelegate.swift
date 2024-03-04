//
//  SceneDelegate.swift
//  MdEditor
//
//  Created by Alexey Turulin on 1/3/24.
//

import UIKit
import TaskManagerPackage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	private var appCoordinator: ICoordinator! // swiftlint:disable:this implicitly_unwrapped_optional

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }

		let (window, coordinator) = makeKeyWindowWithCoordinator(scene: scene)

		self.window = window
		appCoordinator = coordinator

		appCoordinator.start()
	}
}

// MARK: - Private methods

private extension SceneDelegate {

	func makeKeyWindowWithCoordinator(scene: UIWindowScene) -> (UIWindow, ICoordinator) {
		let window = UIWindow(windowScene: scene)
		window.makeKeyAndVisible()

		let navigationController = UINavigationController()

#if DEBUG
		let coordinator = TestAppCoordinator(router: navigationController)
#else
		let coordinator = AppCoordinator(router: navigationController)
#endif

		window.rootViewController = navigationController
		return (window, coordinator)
	}
}
