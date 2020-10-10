//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Manogya Acharya on 10/10/20.
//

import Foundation

class WeatherLocation: Codable{
    var name: String
    var latitude: Double
    var longitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
