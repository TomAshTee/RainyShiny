//
//  Forecast.swift
//  RainyShiny
//
//  Created by Tomasz Jaeschke on 17.03.2017.
//  Copyright © 2017 Tomasz Jaeschke. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    private var _data: String!
    private var _weatherType: String!
    private var _highTemp: String!
    private var _lowTemp: String!
    
    var date: String {
        if _data == nil {
            _data = ""
        }
        return _data
    }
    var weatherTemp: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(weatherDict: Dictionary<String, Any>) {
        
        if let temp = weatherDict["temp"] as? Dictionary<String, Any> {
            if let min = temp["min"] as? Double {
                self._lowTemp = "\(String(format: "%.1f", KalwinToCelsius(kalwin: min)))°C"
            }
            if let max = temp["max"] as? Double {
                self._highTemp = "\(String(format: "%.1f", KalwinToCelsius(kalwin: max)))°C"
            }
        }
        if let weather = weatherDict["weather"] as? [Dictionary<String, Any>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main.capitalized
            }
        }
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._data = unixConvertedDate.dayOfTheWeek().capitalized
        }
    }
}
