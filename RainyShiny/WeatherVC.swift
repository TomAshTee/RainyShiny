//
//  WeatherVC.swift
//  RainyShiny
//
//  Created by Tomasz Jaeschke on 06.03.2017.
//  Copyright © 2017 Tomasz Jaeschke. All rights reserved.
//

import UIKit
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.currentWeather = CurrentWeather()
        
        self.currentWeather.downloadWeatherDetails {
            //Code to update UI
            self.downloadForecastData {
                 self.updateWeatherUI()
            }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            cell.configureCell(forecast: forecasts[indexPath.row])
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete){
        Alamofire.request(FORECAST_URL).responseJSON { response in
            if let dict = response.result.value as? Dictionary<String, Any> {
                if let list = dict["list"] as? [Dictionary<String, Any>] {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func updateWeatherUI(){
        self.dataLabel.text = self.currentWeather.date
        self.currentTempLabel.text = self.currentWeather.currentTemp
        self.locationLabel.text = self.currentWeather.cityName
        self.currentWeatherTypeLabel.text = self.currentWeather.weatherType
        self.currentWeatherImage.image = UIImage(named: self.currentWeather.weatherType)
        
    }
    
}

