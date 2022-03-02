//
//  BaseNetwork.swift
//  WeatherTask
//
//  Created by usama on 02/03/2022.
//

import Foundation

public typealias HTTPHeaders = [String: String]
typealias QueryPairItems = KeyValuePairs<String, String>?

enum HTTPMethod: String {
    case get        = "GET"
    case post       = "POST"
    case put        = "PUT"
    case delete     = "DELETE"
    case patch      = "PATCH"
    case head       = "HEAD"
    case trace      = "TRACE"
    case connect    = "CONNECT"
    case options    = "OPTIONS"
}

enum HTTPContentType: String {
    //If needed more content type can be define here
    case json               = "application/json"
    case xml                = "text/xml; charset=utf-8"
    case formurlencoded     = "application/x-www-form-urlencoded"
    case multipartFormData  = "formData"
}

protocol NetworkEndPoint {
    var url: URL { get }
    var method: HTTPMethod { get }
    var queryItems: QueryPairItems { get }
    var headers: HTTPHeaders? { get }
    var body: Data? { get }
    var caching: URLRequest.CachePolicy { get }
    var timeout: TimeInterval { get }
    var session: URLSession { get }
    var isTesting: Bool { get }
}

// Default implementation of protocol values
extension NetworkEndPoint {

    var queryItems: QueryPairItems? {
        nil
    }

    var headers: HTTPHeaders? {
        nil
    }

    var body: Data? {
        nil
    }

    var caching: URLRequest.CachePolicy {
        .reloadIgnoringLocalAndRemoteCacheData
    }

    var timeout: TimeInterval {
        60
    }
    var session: URLSession {
        URLSession.shared
    }
}

extension URL {
    /// Appends `queryItems` to `URL`. In case of failure returns `self`
    func apending(_ queryItems: QueryPairItems) -> URL {
        guard let queryItems = queryItems else {
            return self
        }
        guard var components = URLComponents(string: absoluteString) else {
            return self
        }
        var items = components.queryItems ?? []
        for (key, val) in queryItems {
            items.append(URLQueryItem(name: key, value: val))
        }
        components.queryItems = items
        let url = components.url
        return components.url ?? self
    }
}
