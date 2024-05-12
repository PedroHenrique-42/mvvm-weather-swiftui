//
//  Models.swift
//  MVVMWeather
//
//  Created by Pedro Henrique on 14/12/23.
//

import Foundation

// DATA

struct WeatherModel: Codable {
    let timezone: String
    let current: CurrentWeather
}

struct CurrentWeather: Codable {
    let temp: Float
    let weather: [WeatherInfo]
}

struct WeatherInfo: Codable {
    let main: String
    let description: String
}
