//
//  Function.swift
//  WeatherAppHZ
//
//  Created by Hiram Zamorano on 11/18/19.
//  Copyright © 2019 Hiram Zamorano. All rights reserved.
//

import Foundation
import UIKit



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
