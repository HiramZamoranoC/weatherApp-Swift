//
//  Location.swift
//  WeatherAppHZ
//
//  Created by Hiram Zamorano on 11/18/19.
//  Copyright © 2019 Hiram Zamorano. All rights reserved.
//

import Foundation
import CoreLocation

class LocationHandler: NSObject {
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    static var sharedInstance = LocationHandler()
    private override init() {}
    var latitude: Double!
    var longitude: Double!
    
}

extension LocationHandler: CLLocationManagerDelegate {
    
    func setUpLocation() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        LocationHandler.sharedInstance.latitude = location.coordinate.latitude
        LocationHandler.sharedInstance.longitude = location.coordinate.longitude
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
