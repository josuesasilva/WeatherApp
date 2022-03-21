//
//  WeatherByLocationRequest.swift
//  WeatherApp
//
//  Created by Josué on 21/03/22.
//

import Foundation

struct WeatherByLocationRequest: NetworkRequestProvider {

    // MARK: - Dependencies

    private let locationId: Int

    // MARK: - Properties

    let method: HTTPMethod = .get

    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "metaweather.com"
        components.path = "/api/location/\(self.locationId)"

        guard let url = components.url else {
            preconditionFailure()
        }

        return url
    }

    // MARK: - Initializers

    init(locationId: Int) {
        self.locationId = locationId
    }
}
