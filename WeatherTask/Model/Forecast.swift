//
//  Forecast.swift
//  WeatherTask
//
//  Created by usama on 05/03/2022.
//

import Foundation

// MARK: - Forecast
struct ForecastRoot: Codable {
    let city: City
    let cod: String
    let message: Message
    let cnt: Int
    let list: [Forecast]

}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let country: String
    let population, timezone: Int
}


// MARK: - List
struct Forecast: Codable {
    let dt, sunrise, sunset: Int
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let weather: [WeatherElement]
    let speed: Double
    let deg: Int
    let gust: Double
    let clouds: Int
    let pop: Double
    let rain: Double?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity, weather, speed, deg, gust, clouds, pop, rain
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day, night, eve, morn: Double
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

//
//struct Message: Codable {
//    var validMessage: Double?
//    var errorMessage: String?
//
//    // Where we determine what type the value is
//    init(from decoder: Decoder) throws {
//        let container =  try decoder.singleValueContainer()
//
//        // Check for a double from valid response
//        do {
//            validMessage = try container.decode(Double.self)
//
//        } catch {
//            // Check for a string
//            errorMessage = try container.decode(String.self)
//        }
//    }
//}


struct Message: Codable {
    let validMessage: Double
    let errorMessage: String

    // Where we determine what type the value is
    init(from decoder: Decoder) throws {
        let container =  try decoder.singleValueContainer()

        // Check for a boolean
        do {
            validMessage = try container.decode(Double.self)
            errorMessage = ""
        } catch {
            // Check for an integer
            errorMessage = try container.decode(String.self)
            validMessage = 0
        }
    }
}
