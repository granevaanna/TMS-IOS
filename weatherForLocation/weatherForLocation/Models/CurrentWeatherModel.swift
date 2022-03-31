//
//  CurrentWeatherModel.swift
//  weatherForLocation
//
//  Created by Анна Гранёва on 18.01.22.
//

import UIKit

struct CurrentWeatherModel: Codable{
    let cityName: String
    
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
            case 200...232:
                return "cloud.bolt.fill"
            case 300...321:
                return "cloud.drizzle.fill"
            case 500...504:
                return "cloud.rain.fill"
            case 511:
                return "cloud.sleet.fill"
            case 520...531:
                return "cloud.heavyrain.fill"
            case 600...622:
                return "cloud.snow.fill"
            case 701...781:
                return "cloud.fog.fill"
            case 800:
                return "sun.max.fill"
            case 801:
                return "cloud.sun"
            case 802:
                return "cloud.sun.fill"
            case 803:
                return "cloud"
            case 804:
                return "cloud.fill"
            default:
                return "thermometer"
            }
        }
    
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.0f", temperature) + "℃"
    }
    
    let weatherDescription: String
    
    let sunrize: Int
    var sunrizeTimeString: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(sunrize)))
    }
    
    let sunset: Int
    var sunsetTimeString: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(sunset)))
    }
    
    init?(weather: WeatherResponse){
        cityName = weather.timezone ?? ""
        conditionCode = weather.current?.weather?.first?.id ?? 0
        temperature = weather.current?.temp ?? 0
        weatherDescription = weather.current?.weather?.first?.description ?? ""
        sunrize = weather.current?.sunrise ?? 0
        sunset = weather.current?.sunset ?? 0
    }
}
