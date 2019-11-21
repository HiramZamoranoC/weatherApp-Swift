//
//  Weather.swift
//  WeatherAppHZ
//
//  Created by Hiram Zamorano on 11/17/19.
//  Copyright © 2019 Hiram Zamorano. All rights reserved.
//

import Foundation

enum WeatherKeys: String, CodingKey {
    case weatherIcon = "weather"
    case name
    case main
}
enum MainKeys: String, CodingKey {
    case temperature = "temp"
    case temperatureMin = "temp_min"
    case temperatureMax = "temp_max"
}

enum WeatherIconKeys: String, CodingKey {
    case icon
}

struct Weather: Decodable {
    var name: String?
    var icon: String?
    var temperature: Double?
    var temperatureMin: Double?
    var temperatureMax: Double?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: WeatherKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        
        if let weatherIcon = try? values.nestedContainer(keyedBy: WeatherIconKeys.self, forKey: .weatherIcon) {
            self.icon = try weatherIcon.decode(String.self, forKey: .icon)
        }
        
        if let main = try? values.nestedContainer(keyedBy: MainKeys.self, forKey: .main) {
            self.temperature = try main.decode(Double.self, forKey: .temperature)
            self.temperatureMin = try main.decode(Double.self, forKey: .temperatureMin)
            self.temperatureMax = try main.decode(Double.self, forKey: .temperatureMax)
        }
        
    }
    
}
