//
//  MCurrent.swift
//  Weather
//
//  Created by Дарья Носова on 28.04.2022.
//

import Foundation
import UIKit


struct WeatherDescription: Decodable, Hashable {
    let description: String?
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



struct ModelWeather: Decodable, Hashable, Identifiable {
    let id: UUID?
    let current: Weather
    let hourly: [Weather]
    let daily: [DailyWeather]
}

enum Link: String {
    case weatherApi = "https://api.openweathermap.org/data/2.5/onecall?lat=33.44&lon=-94.04&exclude=minutely&appid=c4c39f37c5b467c46d473337ce99337d&units=metric&lang=ru"
}
