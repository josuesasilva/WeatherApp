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
        components.host = "metaweather.com"
        components.path = "/static/img/weather/png/\(self.weatherStateAbbreviation).svg"

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
