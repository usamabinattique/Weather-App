//
//  WeatherViewModel.swift
//  WeatherTask
//
//  Created by usama on 02/03/2022.
//

import Foundation

typealias MainThreadCompletion = (String?, Error?) -> Void


class WeatherViewModel {
    
    private(set) var weather: Weather?
    private(set) var forecast: [Forecast] = []
    
    init() { }

}

extension WeatherViewModel {
    func tempConversion(for temp: Double) -> String {
        convertTemp(temp: temp)
    }
}

extension WeatherViewModel {
    func fetchWeatherData(completion: @escaping MainThreadCompletion) {
        let request: WeatherRequestable = WeatherRequest(apiKey: Constants.apiKey,
                                                         city: "Islamabad")
        
        let endPoint = API.currentWeather(request: request)
        APIClient.shared.request(endPoint: endPoint, decode: Weather.self, error: DefaultError.self) { result in
            switch result {
            case let .success(root):
                                
                if let weatherRoot = root as? Weather {
                    self.weather = weatherRoot
                    completion(nil, nil)
                }
            case let .failure(error):
                
                if let unauthorizedError = error as? DefaultError {
                    
                    switch unauthorizedError {
                    case .unauthorized(let response):
                        if let root = response as? ErrorHandler {
                            completion(root.message, nil)
                        }
                    default:
                        completion(nil, error)
                    }
                }
                
                completion(nil, error)
            }
        }
    }
    
    func fetchForecastData(completion: @escaping MainThreadCompletion) {
        let request: ForecastRequestable = ForecastRequest(apiKey: Constants.apiKey,
                                                           city: "Islamabad",
                                                           count: 7)
        
        let endPoint = API.forecast(request: request)
        APIClient.shared.request(endPoint: endPoint, decode: ForecastRoot.self, error: DefaultError.self) { result in
            switch result {
            case let .success(root):
                if let root = root as? ForecastRoot {
                    self.forecast = root.list
                    completion(nil, nil)
                }
            case let .failure(error):
                if let unauthorizedError = error as? DefaultError {
                    
                    switch unauthorizedError {
                    case .unauthorized(let response):
                        if let root = response as? ErrorHandler {
                            completion(root.message, nil)
                        }
                    default:
                        completion(nil, error)
                    }
                }
                
                completion(nil, error)
            }
        }
    }
}
