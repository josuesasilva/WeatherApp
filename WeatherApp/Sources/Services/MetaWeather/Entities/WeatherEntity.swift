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
        let consolidatedWeather: ConsolidatedWeather
    }
    
    struct ConsolidatedWeather: Codable {
        let weatherStateName: String
        let weatherStateAbbreviation: String
        let minTemp: Int
        let maxTemp: Int
        let theTemp: Int
        
        private enum CodingKeys: String, CodingKey {
            case weatherStateName = "weather_state_name"
            case weatherStateAbbreviation = "weather_state_abbr"
            case minTemp = "min_temp"
            case maxTemp = "max_temp"
            case theTemp = "the_temp"
        }
    }
}
