//
//  JSONEncoder.swift
//  WeatherTask
//
//  Created by usama on 02/03/2022.
//


import Foundation

/// JSONDecoder extension whose goal is to make json parsing less verbose
/// instead of try catch, this extension offers returning tuple.
extension JSONDecoder {

    private struct NoType: Error, Decodable { }

    private static let shared: JSONDecoder = {

        let decoder = JSONDecoder()
        return decoder
    }()

    /// JSONDecoder Class method to Decode object
    ///
    /// - Parameters:
    ///   - type: Desired Model
    ///   - data: Data to Parse
    /// - Returns: Parsed object or No Type Error
    class func decode<T>(_ type: T.Type, data: Data?) -> (T?, Error?) where T: Decodable {
        return self.shared.decode(type, errorType: NoType.self, data: data)
    }

    /// JSONDecoder Class method to Decode object
    ///
    /// - Parameters:
    ///   - type: Desired Model
    ///   - errorType: Desired Error Model
    ///   - data: Data to Parse
    /// - Returns: Parsed object or Desired Error Type. If no Error type provided then No Type Error will be return

    class func decode<T, U>(_ type: T.Type, errorType: U.Type? = nil, data: Data?) -> (T?, Error?) where T: Decodable, U: Decodable & Error {
        return self.shared.decode(type, errorType: errorType, data: data)
    }

    /// JSONDecoder Method to Decode object
    ///
    /// - Parameters:
    ///   - type: Desired Model
    ///   - data: Data to Parse
    /// - Returns: Parsed object or No Type Error

    func decode<T>(_ type: T.Type, data: Data?) -> (T?, Error?) where T: Decodable {
        return decode(type, errorType: NoType.self, data: data)
    }

    /// JSONDecoder Method to Decode object
    ///
    /// - Parameters:
    ///   - type: Desired Model
    ///   - errorType: Desired Error Model
    ///   - data: Data to Parse
    /// - Returns: Parsed object or Desired Error Type. If no Error type provided then No Type Error will be return

    func decode<T, U>(_ type: T.Type, errorType: U.Type? = nil, data: Data?) -> (T?, Error?) where T: Decodable, U: Decodable & Error {
        guard let data = data else {
            return (nil, DefaultError.failure(message: "no data"))
        }
        do {
            let result = try decode(type, from: data)
            return (result, nil)
        } catch let DecodingError.typeMismatch(type, context) {
            return (nil, DefaultError.failure(message: "Type '\(type)' mismatch: '\(context.debugDescription)' \ncodingPath:\(context.codingPath)"))

        } catch let DecodingError.keyNotFound(type, context) {
            return (nil, DefaultError.failure(message: "Type '\(type)' Keynotfound: '\(context.debugDescription)' \ncodingPath:\(context.codingPath)"))
        } catch let DecodingError.dataCorrupted(context) {
            return (nil, DefaultError.failure(message: "'\(context.debugDescription)' \ncodingPath:\(context.codingPath)"))
        } catch {
            if let errType = errorType, "\(errType)" != "\(NoType.self)" {
                let (err, _) = decode(errType, errorType: NoType.self, data: data)
                return (nil, err)
            }
            return (nil, DefaultError.failure(message: error.localizedDescription))
        }
    }
}
