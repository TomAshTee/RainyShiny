//
//  Constants.swift
//  RainyShiny
//
//  Created by Tomasz Jaeschke on 10.03.2017.
//  Copyright © 2017 Tomasz Jaeschke. All rights reserved.
//

import Foundation

let BASE_URL = "http://samples.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "b1b15e88fa797225412429c1c50c122a1"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)-36\(LONGITUDE)123\(APP_ID)\(API_KEY)"

