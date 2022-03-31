//
//  APIManager.swift
//  TMS29
//
//  Created by Aleksei Elin on 10.01.22.
//

import Foundation
import Alamofire



final class WeatherModel: Equatable, Hashable, Codable {
    static func == (lhs: WeatherModel, rhs: WeatherModel) -> Bool {
        return lhs.time == rhs.time
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(time)
    }
    
    var location: String
    let temperature: String
    let weatherDescription: String
    let sunrise: String
    let sunset: String
    let timestamp: Int
    
    let time: String
    
    var minAndMaxTemp: String?
    var currentDayString: String?
    // id image
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
    
    init(response: Current) {
        var currentTempString = ""
        if let temp = response.temp {
            currentTempString = "\(Int(temp.rounded()))" + "°"
        }
        self.location = "Минск"
        self.temperature = currentTempString
        self.weatherDescription = response.weather?.first?.description?.capitalizingFirstLetter() ?? ""
        
        self.timestamp = response.dt ?? 0
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        self.sunrise = "☀︎\(formatter.string(from: Date(timeIntervalSince1970: TimeInterval(response.sunrise ?? 0))))"
        self.sunset = "☼\(formatter.string(from: Date(timeIntervalSince1970: TimeInterval(response.sunset ?? 0))))"
        //image background
        self.conditionCode = response.weather?.first?.id ?? 800
        //время обновления погоды
        self.time = "\(formatter.string(from: Date(timeIntervalSince1970: TimeInterval(response.dt ?? 0))))"
    }
    
    
    init(forSunset: Daily) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        self.location = ""
        self.temperature = "Закат"
        self.weatherDescription = ""
        self.sunrise = ""
        self.time = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(forSunset.sunset ?? 0)))
        self.minAndMaxTemp = ""
        self.currentDayString = ""
        self.conditionCode = 800
        self.timestamp = forSunset.sunset ?? 0
                
        self.sunset = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(forSunset.sunset ?? 0)))
    }
    
    init(forSunrise: Daily) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        self.location = ""
        self.temperature = "Рассвет"
        self.weatherDescription = ""
        self.sunset = ""
        
        self.time = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(forSunrise.sunrise ?? 0)))
        self.minAndMaxTemp = ""
        self.currentDayString = ""
        self.conditionCode = 800
        self.timestamp = forSunrise.sunrise ?? 0
        self.sunrise = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(forSunrise.sunrise ?? 0)))
    }
    
    init(dailyResponse: Daily) {
        self.temperature = ""
        self.location = "Минск"
        self.weatherDescription = dailyResponse.weather?.first?.description?.capitalizingFirstLetter() ?? ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        self.sunrise = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(dailyResponse.sunrise ?? 0)))
        self.sunset = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(dailyResponse.sunset ?? 0)))
        
        let max = dailyResponse.temp?.max?.rounded() ?? 0
        let min = dailyResponse.temp?.min?.rounded() ?? 0
        
        self.timestamp = dailyResponse.dt ?? 0
        self.minAndMaxTemp = "Макс.: \(Int(max))°, мин.: \(Int(min))°"
        
        formatter.dateFormat = "EE"
        formatter.locale = Locale(identifier: "ru_RU")
        
        self.currentDayString = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(dailyResponse.dt ?? 0)))
        
        //image weather
        self.conditionCode = dailyResponse.weather?.first?.id ?? 800
        self.time = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(dailyResponse.dt ?? 0)))
    }
    
    // create init for hourly weather model
    init(hourlyResponse: Hourly) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        self.location = ""
        self.temperature = String(hourlyResponse.temp ?? 0.0)
        self.weatherDescription = ""
        self.sunrise = ""
        self.sunset = ""
        self.time = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(hourlyResponse.dt ?? 0)))
        self.minAndMaxTemp = ""
        self.currentDayString = ""
        self.conditionCode = hourlyResponse.weather?.first?.id ?? 800
        self.timestamp = hourlyResponse.dt ?? 0
        
    }
    
}

//shift comm O

struct WeatherFullModel: Codable {
    let currentDay: WeatherModel
    let upcomingDays: [WeatherModel]
    let hourly: [WeatherModel]
}

struct APIManager {
    private static let apiKey = "9f80e6b624ba112e021f1e30ac273765"
    private static let getWeatherRequest = "https://api.openweathermap.org/data/2.5/forecast"
    private static let getOneCallWeatherRequest = "https://api.openweathermap.org/data/2.5/onecall"
    
    
    static func getOneCallWeather(lat: Double, lon: Double, completion: @escaping (WeatherFullModel?) -> Void ) {
        let parameters = [ "appid" : "f8f13c0aba8d9f6ecea281f4453f54cf",
                           "units" : "metric",
                           "exclude" : "minutely",
                           "lat" : "\(lat)",
                           "lon" : "\(lon)",
                           "lang" : "ru"]
        
        AF.request(getOneCallWeatherRequest, parameters: parameters).responseDecodable(of: WeatherOneCallResponse.self) { response in
            if let weather = response.value {
                guard let current = weather.current else { completion(nil); return }
                let currentModel = WeatherModel(response: current)
    
                var daysWeather: [WeatherModel] = []
                if let daily = weather.daily {
                    daysWeather = daily.compactMap({ WeatherModel(dailyResponse: $0) })
                }
                
                var hoursWeather: [WeatherModel] = []
                if let hourly = weather.hourly {
                    hoursWeather = hourly.compactMap({ WeatherModel(hourlyResponse: $0) })
                }
                
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "ru_RU")
                formatter.dateFormat = "EE"
                
                
                var index = 0
                if current.sunset ?? 0 < hoursWeather.first?.timestamp ?? 0 {
                    index = 1
                }
                
                if let daily = weather.daily?[index] {
                    hoursWeather.append(WeatherModel(forSunrise: daily))
                    hoursWeather.append(WeatherModel(forSunset: daily))
                }

                hoursWeather.sort(by: { $0.timestamp < $1.timestamp })

                daysWeather.removeAll(where: { $0.currentDayString == formatter.string(from: Date())})
                
                let fullModel = WeatherFullModel(currentDay: currentModel, upcomingDays: Array(daysWeather.prefix(3)), hourly: Array(hoursWeather.prefix(27)))
               
                
                completion(fullModel)
                
            } else {
                completion(nil)
            }
            
        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
