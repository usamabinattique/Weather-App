//
//  WeatherRequestable.swift
//  WeatherTask
//
//  Created by usama on 02/03/2022.
//

import Foundation

public protocol BaseRequestModel {

}


protocol LocationProvidable {
    var latitiude: String { get set }
    var longitude: String { get set }
}

protocol WeatherRequestable: BaseRequestModel {
    var apiKey: String { get set }
    var city: String { get set }
}

struct WeatherRequest: WeatherRequestable {
    var apiKey: String
    var city: String
}
