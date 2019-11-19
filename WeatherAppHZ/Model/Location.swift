//
//  Location.swift
//  WeatherAppHZ
//
//  Created by Hiram Zamorano on 11/18/19.
//  Copyright © 2019 Hiram Zamorano. All rights reserved.
//

import Foundation
import CoreLocation

class Location: NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    static var sharedInstance = Location()
    private override init() {}
      var latitude: Double!
      var longitude: Double!
    
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
         Location.sharedInstance.latitude = location.coordinate.latitude
         Location.sharedInstance.longitude = location.coordinate.longitude
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print(error.localizedDescription)
       }
 
}
