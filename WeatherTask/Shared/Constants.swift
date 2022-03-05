//
//  Constants.swift
//  WeatherTask
//
//  Created by usama on 02/03/2022.
//


import Foundation

struct Constants {
    
    static let baseUrl = "https://api.openweathermap.org/"

    static let apiKey = "7bcaf2d90ee6d047009c5e0acc743ae6"
    
    static let imageBaseUrl = "http://openweathermap.org/img/wn/"
    
    static let failure = "Failure"
    
    static func imageUrlString(iconCode: String) -> String {
        String(format: "%@%@%@", imageBaseUrl, iconCode, "@2x.png")
    }
}


