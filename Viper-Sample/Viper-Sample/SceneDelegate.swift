//
//  SceneDelegate.swift
//  Viper-Sample
//
//  Created by srbrt on 21.02.2024.
//

import CoreData
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        // Check if the provided scene can be cast to a UIWindowScene.
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        // WeatherVCWireframe'i başlat
        let splashWireframe = SplashWireframe()

        // WeatherVCWireframe ile ilgili modülü göster
        window?.rootViewController = splashWireframe.viewController

        window?.makeKeyAndVisible()
    }
}
