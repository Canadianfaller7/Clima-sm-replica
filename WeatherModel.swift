//
//  WeatherModel.swift
//  Clima
//
//  Created by Spencer Merrill on 7/14/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    let temperatureMax: Double
    let temperatureMin: Double
    
    
    // this is the same as the bottom just returning a computed property to get the temp
    var tempString: String {
        return String(format: "%.0f", temperature)
    }
    var tempMax: String {
        return String(format: "%.0f", temperatureMax)
    }
    var tempMin: String {
        return String(format: "%.0f", temperatureMin)
    }
    
    
    // this is a computed property. It has to be a var and then have a name and then have a data type and then it will return an output that will be set as the value of the property
    var condtionName: String {
        switch conditionID {
        case 199...202:
            return "cloud.bolt.rain"
        case 203...221:
            return "cloud.bolt."
        case 230...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "clould.rain"
        case 600...610:
            return "cloud.snow"
        case 611...616:
            return "cloud.sleet."
        case 701...781:
            return "cloud.fog"
        case 801...804:
            return "cloud"
        
        
        default:
            return "sun.max"
        }
    }
}
