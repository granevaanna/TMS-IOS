//
//  APIManager.swift
//  weatherForLocation
//
//  Created by Анна Гранёва on 18.01.22.
//

import UIKit
import Alamofire

struct WeatherFullModel: Codable{
    let current: CurrentWeatherModel
    let days: [DailyWeatherModel]
}

struct APIManager{
    private static let apiKey = "f396e940bbc5aec3901b90593f3fe3ee"
    private static let getOneCallWeatherRequest = "https://api.openweathermap.org/data/2.5/onecall"

    static func getOneCallWeather(lat: Double, lon: Double, completion: @escaping (WeatherFullModel?) -> Void ) {
        let parameters = [ "appid" : "\(apiKey)",
                           "units" : "metric",
                           "exclude" : "hourly,minutely",
                           "lat" : "\(lat)",
                           "lon" : "\(lon)",
                           "lang" : "ru"]
        AF.request(getOneCallWeatherRequest, parameters: parameters).responseDecodable(of: WeatherResponse.self) { response in
            if let weather = response.value{
                var dailyWeatherModel: [DailyWeatherModel] = []
                guard let dailyWeather = weather.daily,
                      let currentWeather = weather.current,
                      let currentWeatherModel = CurrentWeatherModel(weather: weather) else {return}
                dailyWeatherModel = dailyWeather.compactMap({ DailyWeatherModel(dailyWeatherResponse: $0) })
                let fullWeather = WeatherFullModel(current: currentWeatherModel, days: dailyWeatherModel)
                completion(fullWeather)
            } else {
                completion(nil)
            }
        }
    }
}
