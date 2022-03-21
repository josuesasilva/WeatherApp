//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Josué on 21/03/22.
//

import Foundation

struct WeatherModel {
    let temperature: String
    let maxTemperature: String
    let minTemperature: String
    let weatherDescription: String
    let weatherAbbreviation: String
    let cityName: String
}

enum HomeViewModelState {
    case fetching
    case ready(data: WeatherModel)
    case error
}

protocol HomeViewModelProvider {
    var state: HomeViewModelState { get }
    var delegate: HomeViewModelStateDelegate? { get set }

    func loadWeather()
}

protocol HomeViewModelStateDelegate: AnyObject {
    func onHomeViewModelStateUpdate(newState: HomeViewModelState)
}

final class HomeViewModel: HomeViewModelProvider {

    // MARK: - Dependencies

    private let networkService: NetworkServiceProvider
    private let locationId: Int

    // MARK: - Properties

    var state: HomeViewModelState {
        didSet {
            self.delegate?.onHomeViewModelStateUpdate(newState: self.state)
        }
    }
    weak var delegate: HomeViewModelStateDelegate?

    // MARK: - Initializers

    init(networkService: NetworkServiceProvider, locationId: Int) {
        self.state = .fetching
        self.networkService = networkService
        self.locationId = locationId
    }

    // MARK: - HomeViewModelProvider

    func loadWeather() {
        loadData()
    }

    // MARK: - Private methods

    private func loadData() {
        let request = WeatherByLocationRequest(locationId: locationId)

        self.state = .fetching

        networkService.requestCodable(request, ofType: WeatherEntity.Wheather.self) { [weak self] result in
            switch result {
            case .success(let data):
                let mostPredictableWeather = data.consolidatedWeather.sorted(
                    // swiftlint:disable unused_closure_parameter
                    by: {(`left`, `right`) in `left`.predictability > `right`.predictability }
                )
                let consolidatedWeather = mostPredictableWeather.first ?? .init(
                    weatherStateName: "",
                    weatherStateAbbreviation: "",
                    minTemp: 0,
                    maxTemp: 0,
                    theTemp: 0,
                    predictability: 0
                )
                self?.state = .ready(
                    data: .init(
                        temperature: "\(Int(consolidatedWeather.theTemp))°",
                        maxTemperature: "H: \(Int(consolidatedWeather.maxTemp))°",
                        minTemperature: "L: \(Int(consolidatedWeather.minTemp))°",
                        weatherDescription: consolidatedWeather.weatherStateName,
                        weatherAbbreviation: consolidatedWeather.weatherStateAbbreviation,
                        cityName: data.title
                    )
                )
            case .failure(let error):
                print(error)
                self?.state = .error
            }
        }
    }
}
