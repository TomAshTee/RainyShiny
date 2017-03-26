//
//  WeatherVC.swift
//  RainyShiny
//
//  Created by Tomasz Jaeschke on 06.03.2017.
//  Copyright © 2017 Tomasz Jaeschke. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.currentWeather = CurrentWeather()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            //print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
            //print(CURRENT_WEATHER_URL)
            self.currentWeather.downloadWeatherDetails {
                //Code to update UI
                self.downloadForecastData {
                    self.updateWeatherUI()
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
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
            //print(response.result.value!)
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

