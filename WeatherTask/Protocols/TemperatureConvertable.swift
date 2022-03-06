//
//  TemperatureConvertable.swift
//  WeatherTask
//
//  Created by usama on 05/03/2022.
//

import Foundation

protocol TemperatureConvertable {
    func convertTemp(temp: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String
}

extension TemperatureConvertable {
    
    func convertTemp(temp: Double, from inputTempType: UnitTemperature = .kelvin, to outputTempType: UnitTemperature = .celsius) -> String {
        let mf = MeasurementFormatter()
        mf.numberFormatter.maximumFractionDigits = 0
        mf.unitOptions = .providedUnit
        let input = Measurement(value: temp, unit: inputTempType)
        let output = input.converted(to: outputTempType)
        return mf.string(from: output)
    }
}

extension WeatherViewModel: TemperatureConvertable { }
extension ForecastCell: TemperatureConvertable { }

