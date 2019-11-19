//
//  WeatherRequest.swift
//  WeatherAppHZ
//
//  Created by Hiram Zamorano on 11/13/19.
//  Copyright © 2019 Hiram Zamorano. All rights reserved.
//

import Foundation
import CoreLocation

class APIController {
    
    fileprivate let baseURL = "http://api.openweathermap.org/data"
    fileprivate let versionAPI = "2.5"
    fileprivate let typeAPI = "weather"
    fileprivate let apiKey = "c70ff4cc260c1075bbfb6849caa1ad29"
//    fileprivate let latitude = 29.1026
//    fileprivate let longitude = -110.97732
   
    func getWeather(completion: @escaping (_ weather: Weather?, _ error: Error?) -> Void) {
        let URLPath = "\(baseURL)/\(versionAPI)/\(typeAPI)?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=\(apiKey)&units=metric"
        getJSONFromURL(urlString: URLPath) { (data, error) in
            guard let data = data, error == nil else {
                print("Error, Failed to get data")
                return completion(nil, error)
            }
            self.createWeatherObject(json: data, completion: { (weather, error) in
                if let error = error {
                    print("Failed, cannot convert data")
                    return completion(nil, error)
                }
                return completion(weather, nil)
            })
        }
    }
}

extension APIController {
    private func getJSONFromURL(urlString: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Error, cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            guard error == nil else {
                print("Error API call")
                return completion(nil, error)
            }
            guard let responseData = data else {
                print("Data nil")
                return completion(nil, error)
            }
            completion(responseData, nil)
        }
        task.resume()
    }
    
    private func createWeatherObject(json: Data, completion: @escaping (_ data: Weather?, _ error: Error?) -> Void) {
        do {
            let decoder = JSONDecoder()
            let weather = try decoder.decode(Weather.self, from: json)
            return completion(weather, nil)
        } catch let error {
            print("Error: \(error.localizedDescription)")
            return completion(nil, error)
        }
    }
}
