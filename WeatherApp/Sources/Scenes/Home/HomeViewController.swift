//
//  ViewController.swift
//  WeatherApp
//
//  Created by Josué on 20/03/22.
//

import Kingfisher
import UIKit

class HomeViewController: UIViewController {

    private let viewModel: HomeViewModelProvider
    weak var contentView: ContentView?

    init(viewModel: HomeViewModelProvider) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.loadWeather()
    }

    override func loadView() {
        view = ContentView(state: .loading)
        view.backgroundColor = .white

        contentView = view as? ContentView
    }
}

extension HomeViewController: HomeViewModelStateDelegate {

    func onHomeViewModelStateUpdate(newState: HomeViewModelState) {
        switch newState {
        case .fetching:
            contentView?.setState(.loading)
        case .ready(let viewModel):
            contentView?.weatherIcon.kf.setImage(with: viewModel.iconUrl)
            contentView?.setState(
                .data(
                    cityName: viewModel.cityName,
                    temperature: viewModel.temperature,
                    maxTemperature: viewModel.maxTemperature,
                    minTemperature: viewModel.minTemperature,
                    weather: viewModel.weatherDescription
                )
            )
        case .error:
            contentView?.setState(.error)
        }
    }

}
