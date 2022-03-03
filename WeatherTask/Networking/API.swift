//
//  API.swift
//  WeatherTask
//
//  Created by usama on 02/03/2022.
//

import UIKit

/// Main `NetworkEndPoint`s for the app
enum API: NetworkEndPoint {
    case weather(request: BaseRequestModel)
}

/// Implementation of `NetworkEndPoint`
 extension API {
     
    var isTesting: Bool {
        false
    }
     
    /// path for the endpoint
    var path: String {
        "data/2.5/weather"
    }
     
    /// Query items for endpoint
    var queryItems: KeyValuePairs<String, String>? {
        switch self {
        case let .weather(weatherRequest):
            
            if let weatherRequest = weatherRequest as? WeatherRequestable {
                return ["apiKey": weatherRequest.apiKey,
                        "q": weatherRequest.city]
            }
            
            return nil
        }
    }

    /// Body disctionary for endpotins
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
        URL(string: "https://api.openweathermap.org/")!
     }
 }

private extension API {
    func encode<T>(request: T) -> Data? where T: Codable {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        do {

            let data = try encoder.encode(request)
            return data

        } catch {

        }
        return nil
    }
}

extension URL {
    mutating func appendURLWithQueryParams(newVal: String) {
        appendPathComponent(newVal)
    }
}
