//
//  Location.swift
//  RainyShiny
//
//  Created by Tomasz Jaeschke on 26.03.2017.
//  Copyright © 2017 Tomasz Jaeschke. All rights reserved.
//

import Foundation
import CoreLocation

//Singleton class
class Location {
    static var sharedInstance = Location()
    private init () {}
    
    var latitude: Double!
    var longitude: Double!
}
