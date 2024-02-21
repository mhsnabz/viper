//
//  SceneDelegate.swift
//  Viper-Sample
//
//  Created by srbrt on 21.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        // Check if the provided scene can be cast to a UIWindowScene.
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Start the main router to set up the initial configuration of the app.
        let mainRouter = MainRouter.start()

        // Retrieve the initial view controller from the main router.
        let initialVC = mainRouter.entryPoint

        // Create a new UIWindow instance using the provided window scene.
        let window = UIWindow(windowScene: windowScene)

        // Set the initial view controller as the root view controller of the window.
        window.rootViewController = initialVC

        // Make the window key and visible.
        window.makeKeyAndVisible()

        // Store the window reference in the scene delegate.
        self.window = window
    }
}
