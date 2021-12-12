//
//  NetworkService.swift
//  TMS23
//
//  Created by Aleksei Elin on 9.12.21.
//

import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.openweathermap.org"
    
    
    static let getWeatherForFourDays = "/data/2.5/forecast"
    static let getCurrentWeather = "/data/2.5/weather"
}


protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}


final class APIRequests {
    private static let networking = NetworkService()
    
    static func getWeatherWith(city: String, response: @escaping (WeatherResponse?, String?) -> Void ) {
        networking.request(path: API.getCurrentWeather,
                           params: ["q": city]) { data, error in
            
            if let error = error {
                response(nil, error.localizedDescription)
                
            } else {
                
            guard let data = data,
                  let weather = try? JSONDecoder().decode(WeatherResponse.self, from: data) else {
                      response(nil, "Parsing data error")
                      return
                  }
    
                response(weather, nil)
            }
        }
    }
    
    static func getDailyWeatherWith(city: String, response: @escaping (DailyResponse?, String?) -> Void ) {
        networking.request(path: API.getWeatherForFourDays,
                           params: ["q": city]) { data, error in
            
            if let error = error {
                response(nil, error.localizedDescription)
                
            } else {
                
            guard let data = data,
                  let weather = try? JSONDecoder().decode(DailyResponse.self, from: data) else {
                      response(nil, "Parsing data error")
                      return
                  }
    
                response(weather, nil)
                
            }
        }
    }
    
}

final class NetworkService: Networking {
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        
        let allParams = [ "appid" : "64b33b91272f06dc53f406df2349ea19",
                          "units" : "metric",
                          "lang" : "ru" ]
        
        let url = self.url(from: path, params: allParams.merging(params) { $1 })
        
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        
        task.resume()
        
        print(url)
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let response = response { print(response) }
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
    
    private func url(from path: String, params: [String : String]) -> URL {
        var components = URLComponents()
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url!
    }
}
