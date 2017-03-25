//
//  WeatherCell.swift
//  RainyShiny
//
//  Created by Tomasz Jaeschke on 17.03.2017.
//  Copyright © 2017 Tomasz Jaeschke. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    func configureCell(forecast: Forecast){
        
        lowTemp.text = forecast.date
        highTemp.text = forecast.highTemp
        weatherType.text = forecast.weatherType
        dayLabel.text = forecast.date
        weatherIcon.image = UIImage(named: "\(forecast.weatherType) Mini")
        
    }

}
