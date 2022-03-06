//
//  DefaultError.swift
//  WeatherTask
//
//  Created by usama on 02/03/2022.
//

import Foundation

enum DefaultError: Error {

    case unknown
    case exception(error: Error?)
    case failure(message: String)
    case responseError(errorStatus: Error?)
    case unauthorized(data: Decodable)
}

extension DefaultError: Decodable {
    enum CodingKeys: String, CodingKey {
        case unknown
        case responseError = "error"
    }

    init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else {
            self = .unknown
            return
        }
        if let msg = try? container.decode(String.self, forKey: .unknown) {
            self = .failure(message: msg)
            return
        }
        if let apiError = try? container.decode(ErrorStatus.self, forKey: .responseError) {
            self = .responseError(errorStatus: apiError)
            return
        }
        self = .unknown
    }
}

extension DefaultError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .exception(let error):
            if let decoding = error as? DecodingError {
                SharedLogger.logException(decoding)
                return decoding.localizedDescription
            }
            if let error = error {
                return error.localizedDescription
            }
            return "No exception error message"
        case .responseError(let errorStatus):
            if let errorStatus = errorStatus as? ErrorStatus {
                return errorStatus.errorDetails.text
            }
            return "No response error message"
        case .failure(let message):
            return message
        default:
            return "No error message"
        }
    }
}

struct ErrorStatus: Error, Decodable {
    let succeeded: Bool
    let errorDetails: ErrorDetails
}

// MARK: - ErrorStatus
extension ErrorStatus {
    enum CodingKeys: String, CodingKey {
        case succeeded
        case errorDetails = "error"
    }
    /// Decoding Response
    ///
    /// - Parameter decoder: Decoder
    /// - Throws: Error
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        succeeded = try container.decode(Bool.self, forKey: .succeeded)
        errorDetails = try container.decode(ErrorDetails.self, forKey: .errorDetails)
    }
}

struct ErrorDetails: Codable {
    let code: Int
    let text: String
}
