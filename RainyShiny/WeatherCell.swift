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
        
        lowTemp.text = forecast.lowTemp
        highTemp.text = forecast.highTemp
        weatherType.text = forecast.weatherTemp
        dayLabel.text = forecast.date
        weatherIcon.image = UIImage(named: "\(forecast.weatherTemp) Mini")
        
    }

}
