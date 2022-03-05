//
//  ForecastRequestable.swift
//  WeatherTask
//
//  Created by usama on 05/03/2022.
//

import Foundation

protocol ForecastRequestable: BaseRequestModel {
    var apiKey: String { get set }
    var city: String { get set }
    var count: Int { get set }
}

struct ForecastRequest: ForecastRequestable {
    
    var apiKey: String
    var city: String
    var count: Int
    
}
