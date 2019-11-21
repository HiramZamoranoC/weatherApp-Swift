//
//  Function.swift
//  WeatherAppHZ
//
//  Created by Hiram Zamorano on 11/18/19.
//  Copyright © 2019 Hiram Zamorano. All rights reserved.
//

import Foundation
import UIKit

class Function {
    func specialEffect(view: UIView, intensity: Double) {
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
    
    func celsiusToFahrenheit(tempInC: Int) -> Int {
        let fahrenheit = (tempInC * 9/5) + 32
        return fahrenheit as Int
    }
    
    func fahrenheitToCelsius(tempInF: Int) -> Int {
        let celsius = (tempInF - 32) * (5/9)
        return celsius as Int
    }
}
