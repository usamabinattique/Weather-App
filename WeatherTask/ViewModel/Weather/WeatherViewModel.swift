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
    init() { }
}


extension WeatherViewModel {
    func fetchWeatherData(completion: @escaping MainThreadCompletion) {
        let request: WeatherRequestable = WeatherRequest(apiKey: Constants.apiKey,
                                                         city: "Islamabad")
        
        let endPoint = API.weather(request: request)
        APIClient.shared.request(endPoint: endPoint, decode: Weather.self, error: DefaultError.self) { result in
            switch result {
            case let .success(root):
                if let weatherRoot = root as? Weather {
                    self.weather = weatherRoot
                    completion(nil, nil)
                }
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
}
