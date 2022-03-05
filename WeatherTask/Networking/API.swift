//
//  API.swift
//  WeatherTask
//
//  Created by usama on 02/03/2022.
//

import UIKit

/// Main `NetworkEndPoint`s for the app
enum API: NetworkEndPoint {
    case currentWeather(request: BaseRequestModel)
    case forecast(request: BaseRequestModel)
}

/// Implementation of `NetworkEndPoint`
 extension API {
     
    var isTesting: Bool {
        false
    }
     
    /// path for the endpoint
     var path: String {
         
         switch self {
         case .currentWeather:
             return "data/2.5/weather"
         case .forecast:
             return "data/2.5/forecast/daily"
         }
     }
     
    /// Query items for endpoint
    var queryItems: KeyValuePairs<String, String>? {
        switch self {
        case let .currentWeather(weatherRequest):
            
            if let weatherRequest = weatherRequest as? WeatherRequestable {
                return ["apiKey": weatherRequest.apiKey,
                        "q": weatherRequest.city]
            }
            
            return nil
        case let .forecast(forecastRequest):
            if let forecastRequest = forecastRequest as? ForecastRequestable {
                return ["apiKey": forecastRequest.apiKey,
                        "q": forecastRequest.city,
                        "count": "\(forecastRequest.count)"]
            }
            
            return nil
        }
    }

    /// Body dictionary for endpoints
    var body: Data? {
         nil
    }
    var contentType: HTTPContentType {
        .json
    }

    /// http method for endpoint
    var method: HTTPMethod {
        .get
    }

    /// Default headers
     var headers: [String: String]? {
        nil
     }
     
     var url: URL {
         URL(string: Constants.baseUrl)!.appendingPathComponent(path)
     }
 }
