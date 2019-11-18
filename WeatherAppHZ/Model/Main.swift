//
//  CurrentWeather.swift
//  WeatherAppHZ
//
//  Created by Hiram Zamorano on 11/8/19.
//  Copyright © 2019 Hiram Zamorano. All rights reserved.
//
import Foundation

struct Main {
    let temperature: Double?
    let temperatureMin: Double?
    let temperatureMax: Double?
}

extension Main: Codable {
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temperature = try values.decodeIfPresent(Double.self, forKey: .temperature)
        temperatureMin = try values.decodeIfPresent(Double.self, forKey: .temperatureMin)
        temperatureMax = try values.decodeIfPresent(Double.self, forKey: .temperatureMax)
    }
    
}
