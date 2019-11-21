//
//  ViewController.swift
//  WeatherAppHZ
//
//  Created by Hiram Zamorano on 11/4/19.
//  Copyright © 2019 Hiram Zamorano. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var iconLabel: UIImageView!
    @IBOutlet weak var specialBG: UIImageView!
    @IBOutlet weak var changeUnit: UISwitch!
    
    private let apiManager = APIManager()
    let functions = Function()
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationHandler.sharedInstance.setUpLocation()
        applyEffect()
        //        getWeather()
        
    }
}

extension ViewController {
    private func getWeather() {
        apiManager.getWeather {(weather, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            guard let weather = weather else { return }
            print("***************")
            print(weather)
            print("***************")
            DispatchQueue.main.async {
                
                //                self.iconLabel.image = UIImage(named: weather.icon[0].icon ?? "null")
                self.locationLabel.text = weather.name
                self.temperatureLabel.text = String(Int(round(weather.temperature ?? 0)))
                self.tempMinLabel.text = String(Int(round(weather.temperatureMin ?? 0)))
                self.tempMaxLabel.text = String(Int(round(weather.temperatureMax ?? 0)))
            }
        }
    }
    
    @IBAction func changeUnit(_ sender: UISwitch) {
        if sender.isOn {
            getWeather()
            self.tempLabel.text = "℃"
            self.minLabel.text = "℃"
            self.maxLabel.text = "℃"
            
        } else {
            self.temperatureLabel.text = String(functions.celsiusToFahrenheit(tempInC: (Int(temperatureLabel.text ?? "nil")!)))
            self.tempMinLabel.text = String(functions.celsiusToFahrenheit(tempInC: (Int(tempMinLabel.text ?? "nil")!)))
            self.tempMaxLabel.text = String(functions.celsiusToFahrenheit(tempInC: (Int(tempMaxLabel.text ?? "nil")!)))
            self.tempLabel.text = "℉"
            self.minLabel.text = "℉"
            self.maxLabel.text = "℉"
        }
    }
    
    @IBAction func reloadButton(_ sender: Any) {
        self.changeUnit.isOn = true
        self.tempLabel.text = "℃"
        self.minLabel.text = "℃"
        self.maxLabel.text = "℃"
        getWeather()
    }
    
    func applyEffect() {
        functions.specialEffect(view: specialBG, intensity: 30)
    }
}
