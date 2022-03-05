//
//  Location.swift
//  WeatherTask
//
//  Created by usama on 04/03/2022.
//


import CoreLocation

class Location {
    
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
