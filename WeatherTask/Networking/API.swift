//
//  API.swift
//  WeatherTask
//
//  Created by usama on 02/03/2022.
//

import UIKit

/// Main `NetworkEndPoint`s for the app
enum API: NetworkEndPoint {
    case weather
}

/// Implementation of `NetworkEndPoint`
 extension API {
     
    var isTesting: Bool {
        return false
    }
     
    /// path for the endpoint
    var path: String {
        switch self {
        case .weather:
            return "api/weather/"
        }
    }
    /// Query items for endpoint
    var queryItems: KeyValuePairs<String, String>? {
        return nil
    }

    /// Body disctionary for endpotins
    var body: Data? {
        switch self {
        case .weather:
            return nil
        default:
            return nil
        }
    }
    var contentType: HTTPContentType {
        return .json
    }

    /// http method for endpoint
    var method: HTTPMethod {
        return .get
    }

    /// Default headers
     var headers: [String: String]? {
         return nil
     }
     
     var url: URL {
         return URL(string: "")!
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
