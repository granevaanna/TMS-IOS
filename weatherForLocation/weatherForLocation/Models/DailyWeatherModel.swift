//
//  DailyWeatherModel.swift
//  weatherForLocation
//
//  Created by Анна Гранёва on 18.01.22.
//

import UIKit

struct DailyWeatherModel: Codable{
    let day: Int
    
    var dayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE, dd MMM"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(day)))
    }
    
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
    
    let dayTemperature: Double
    let nightTemperature: Double
    var temperatureString: String {
        return String(format: "%.0f", dayTemperature) + " / " + String(format: "%.0f", nightTemperature)
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
    
    init?(dailyWeatherResponse: Daily){
        day = dailyWeatherResponse.dt ?? 0
        conditionCode = dailyWeatherResponse.weather?.first?.id ?? 0
        dayTemperature = dailyWeatherResponse.temp?.day ?? 0
        nightTemperature = dailyWeatherResponse.temp?.night ?? 0
        weatherDescription = dailyWeatherResponse.weather?.first?.description ?? ""
        sunrize = dailyWeatherResponse.sunrise ?? 0
        sunset = dailyWeatherResponse.sunset ?? 0
    }
}
