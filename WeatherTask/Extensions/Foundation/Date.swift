//
//  Date.swift
//  WeatherTask
//
//  Created by usama on 03/03/2022.
//

import Foundation

extension Date {
    func toString(formatter: DateFormatter = Formatter.standard) -> String {
        formatter.string(from: self)
    }
}
