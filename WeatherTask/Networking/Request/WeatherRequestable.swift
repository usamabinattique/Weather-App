//
//  WeatherRequestable.swift
//  WeatherTask
//
//  Created by usama on 02/03/2022.
//

import Foundation

public protocol BaseRequestModel { }

protocol WeatherRequestable: BaseRequestModel {
    var apiKey: String { get set }
}

struct WeatherRequest: WeatherRequestable {
    var apiKey: String
}
