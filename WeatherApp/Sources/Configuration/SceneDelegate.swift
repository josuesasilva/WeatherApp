//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Josué on 20/03/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene, willConnectTo
        session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowsScene)
        let configurator = HomeConfigurator()
        let homeViewController = configurator.resolveViewController()
        let navigationController = UINavigationController(rootViewController: homeViewController)
        window?.rootViewController = navigationController
        window?.frame = UIScreen.main.bounds
        window?.makeKeyAndVisible()
    }

}
