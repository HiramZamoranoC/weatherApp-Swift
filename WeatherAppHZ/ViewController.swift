//
//  ViewController.swift
//  WeatherAppHZ
//
//  Created by Hiram Zamorano on 11/4/19.
//  Copyright © 2019 Hiram Zamorano. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
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
    
    private let apiController = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyEffect()
    }
    
    @IBAction func reloadButton(_ sender: Any) {
        getWeather()
        
    }
    @IBAction func changeUnit(_ sender: UISwitch) {
        if sender.isOn {
            self.tempLabel.text = "℃"
            self.minLabel.text = "℃"
            self.maxLabel.text = "℃"
            
        } else {
            self.tempLabel.text = "℉"
            self.minLabel.text = "℉"
            self.maxLabel.text = "℉"
        }
    }
    
}

extension ViewController {
    private func getWeather() {
        apiController.getWeather() {(weather, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            guard let weather = weather else { return }
            print("Weather Object:")
            print(weather.icon)
            DispatchQueue.main.async { // Correct
                
                self.locationLabel.text = weather.name
                if let value = weather.main.temperature {
                    self.temperatureLabel.text = String(Int(round(value)))
                } else {
                    self.temperatureLabel.text = "Free"
                }
                
                if let value = weather.main.temperatureMin {
                    self.tempMinLabel.text = String(Int(round(value)))
                } else {
                    self.tempMinLabel.text = "Free"
                }
                
                if let value = weather.main.temperatureMax {
                    self.tempMaxLabel.text = String(Int(round(value)))
                } else {
                    self.tempMaxLabel.text = "Free"
                }
            }
        }
    }
    
    func applyEffect(){
          specialEffect(view: specialBG, intensity: 30)
      }
    
    func specialEffect(view: UIView, intensity: Double){
         let horizontalMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
         horizontalMotion.minimumRelativeValue = -intensity
         horizontalMotion.maximumRelativeValue = intensity
         
         let verticalMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
         verticalMotion.minimumRelativeValue = -intensity
         verticalMotion.maximumRelativeValue = intensity
         
         let movement = UIMotionEffectGroup()
         movement.motionEffects = [horizontalMotion, verticalMotion]
         
         view.addMotionEffect(movement)
     }
}
