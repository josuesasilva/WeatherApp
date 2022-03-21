//
//  WeatherEntity.swift
//  WeatherApp
//
//  Created by Josué on 21/03/22.
//

import Foundation

enum WeatherEntity {

    struct Wheather: Codable {
        let title: String
        let consolidatedWeather: [ConsolidatedWeather]

        // swiftlint:disable nesting
        private enum CodingKeys: String, CodingKey {
            case title = "title"
            case consolidatedWeather = "consolidated_weather"

        }
    }

    struct ConsolidatedWeather: Codable {
        let weatherStateName: String
        let weatherStateAbbreviation: String
        let minTemp: Double
        let maxTemp: Double
        let theTemp: Double
        let predictability: Int

        // swiftlint:disable nesting
        private enum CodingKeys: String, CodingKey {
            case weatherStateName = "weather_state_name"
            case weatherStateAbbreviation = "weather_state_abbr"
            case minTemp = "min_temp"
            case maxTemp = "max_temp"
            case theTemp = "the_temp"
            case predictability = "predictability"
        }
    }
}
