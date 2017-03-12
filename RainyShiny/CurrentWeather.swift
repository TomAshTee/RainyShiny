//
//  CurrentWeather.swift
//  RainyShiny
//
//  Created by Tomasz Jaeschke on 10.03.2017.
//  Copyright © 2017 Tomasz Jaeschke. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    
    public var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    public var date: String{
        if _date == nil {
            _date = ""
        }
        
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .long
        dateFormater.timeStyle = .none
        let currentDate = dateFormater.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    public var weatherType: String {
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    public var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete){
        //Alamofire download
        //let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            if let dict = response.result.value as? Dictionary<String, Any> {
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                }
                if let weather = dict["weather"] as? [Dictionary<String, Any>] {
                    if let main = weather[0]["main"] as? String{
                        self._weatherType = main.capitalized
                    }
                }
                if let main = dict["main"] as? Dictionary<String, Any> {
                    if let currentTemp = main["temp"] as? Double {
                        self._currentTemp = self.KalwinToCelsius(kalwin: currentTemp)
                    }
                }
            }
        }
        completed()
    }
    
    private func KalwinToCelsius(kalwin: Double) -> (Double) {
        return (kalwin - 273.15)
    }
    
}
