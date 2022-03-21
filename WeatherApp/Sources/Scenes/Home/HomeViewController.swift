//
//  ViewController.swift
//  WeatherApp
//
//  Created by Josué on 20/03/22.
//

import UIKit

class HomeViewController: UIViewController {

    weak var contentView: ContentView?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        view = ContentView(state: .data(cityName: "Cidade", temperature: 1, maxTemperature: 2, minTemperature: 1, weather: "Boa"))
        view.backgroundColor = .white

        contentView = view as? ContentView
    }
}
