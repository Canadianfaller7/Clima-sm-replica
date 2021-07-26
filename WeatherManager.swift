//
//  WeatherManager.swift
//  Clima
//
//  Created by Spencer Merrill on 7/8/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=a61b36fe8c520107f169f4a01a144e8b&units=imperial"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        
        let city = cityName.replacingOccurrences(of: " ", with: "+")
        
        let urlString = "\(weatherURL)&q=\(city)"
        
        performRequest(with: urlString)
    }
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    // this is the networking of the live data from open weather map
    func performRequest(with urlString: String) {
        
        //1. Create URL
        if let url = URL(string: urlString) {
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            //4. Start the task
            
            task.resume()
            
        }
    }
    // this passes the weather from a JSON to a swift object
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let tempMax = decodedData.main.temp_max
            let tempMin = decodedData.main.temp_min
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp, temperatureMax: tempMax, temperatureMin: tempMin)
            
            return weather
           
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
   
}
