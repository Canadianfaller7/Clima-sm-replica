//
//  WeatherData.swift
//  Clima
//
//  Created by Spencer Merrill on 7/8/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}
struct Main: Codable {
    let temp: Double
    let temp_max: Double
    let temp_min: Double
}
struct Weather: Codable {
    let description: String
    let id: Int
    
}

