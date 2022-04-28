//
//  MCurrent.swift
//  Weather
//
//  Created by Дарья Носова on 28.04.2022.
//

import Foundation
import UIKit


struct WeatherDescription: Decodable, Hashable {
    let descirption: String
    let icon: String
}



struct Weather: Decodable, Hashable {
    let dt: Int
    let temp: Double
    let feels_like: Double
    let weather: [WeatherDescription]
}



struct DailyTemperature: Decodable, Hashable {
    let day: Double
    let night: Double
}



struct DailyWeather: Decodable, Hashable {
    let dt: Int
    let temp: DailyTemperature
    let weather: [WeatherDescription]
}



struct ModelWeather: Decodable, Hashable {
    let current: Weather
    let hourly: [Weather]
    let daily: [DailyWeather]
}
