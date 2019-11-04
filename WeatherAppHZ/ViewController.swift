//
//  ViewController.swift
//  WeatherAppHZ
//
//  Created by Hiram Zamorano on 11/4/19.
//  Copyright © 2019 Hiram Zamorano. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var changeUnit: UISwitch!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    @IBAction func changeUnit(_ sender: UISwitch) {
        if sender.isOn{
            unit = "metric"
            self.tempLabel.text = "℃"
            self.minLabel.text = "℃"
            self.maxLabel.text = "℃"
            
        }
        else{
            unit = "imperial"
            self.tempLabel.text = "℉"
            self.minLabel.text = "℉"
            self.maxLabel.text = "℉"
        }
    }
    
    
    let apiKey = "c70ff4cc260c1075bbfb6849caa1ad29"
    //Default Values
    var lat = 11.34
    var lon = 104.33
    let locationManager = CLLocationManager()
    var unit = "metric"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.requestWhenInUseAuthorization()
        
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        lat = location.coordinate.latitude
        lon = location.coordinate.longitude
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=\(unit)").responseJSON {
            response in
            if let responseStr = response.result.value {
                
                let jsonResponse = JSON(responseStr)
                let jsonTemp = jsonResponse["main"]
                
                self.locationLabel.text = jsonResponse["name"].stringValue
                self.temperatureLabel.text = "\(Int(round(jsonTemp["temp"].doubleValue)))"
                self.tempMinLabel.text = "\(Int(round(jsonTemp["temp_min"].doubleValue)))"
                self.tempMaxLabel.text = "\(Int(round(jsonTemp["temp_max"].doubleValue)))"
            }
        }
        
    }
    
    
}

