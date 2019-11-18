//
//  Weather.swift
//  WeatherAppHZ
//
//  Created by Hiram Zamorano on 11/17/19.
//  Copyright © 2019 Hiram Zamorano. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let main: Main
    let name: String
    let icon: [WeatherIcon]
    
    enum CodingKeys: String, CodingKey {
        case main
        case name
        case icon = "weather"
    }
}
