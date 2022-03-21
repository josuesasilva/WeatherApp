//
//  HomeConfigurator.swift
//  WeatherApp
//
//  Created by Josué on 20/03/22.
//

import UIKit

protocol HomeSceneProvider {
    func resolveViewController() -> UIViewController
}

final class HomeConfigurator: HomeSceneProvider {
    func resolveViewController() -> UIViewController {
        return HomeViewController()
    }
}
