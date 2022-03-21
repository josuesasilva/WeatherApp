//
//  WeatherIconRequest.swift
//  WeatherApp
//
//  Created by Josué on 21/03/22.
//

import Foundation

struct WeatherIconRequest: NetworkRequestProvider {

    // MARK: - Dependencies

    private let weatherStateAbbreviation: String

    // MARK: - Properties

    let method: HTTPMethod = .get

    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.metaweather.com"
        components.path = "/static/img/weather/png/64/\(self.weatherStateAbbreviation).png"

        guard let url = components.url else {
            preconditionFailure()
        }

        return url
    }

    // MARK: - Initializers

    init(weatherStateAbbreviation: String) {
        self.weatherStateAbbreviation = weatherStateAbbreviation
    }
}
