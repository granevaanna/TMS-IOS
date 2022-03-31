//
//  CurrentDayWeatherCell.swift
//  TMS29
//
//  Created by Aleksei Elin on 13.01.22.
//

import UIKit

final class CurrentDayWeatherCell: UITableViewCell {
    static let identifier = "CurrentDayWeatherCell"
    
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var minAndMaxTempLabel: UILabel!
    @IBOutlet private weak var sunriseLabel: UILabel!
    @IBOutlet private weak var sunsetLabel: UILabel!
    
    func setupWith(currentWeatherModel: WeatherModel) {
        locationLabel.text = currentWeatherModel.location
        tempLabel.text = currentWeatherModel.temperature
        descriptionLabel.text = currentWeatherModel.weatherDescription
        minAndMaxTempLabel.text = currentWeatherModel.minAndMaxTemp
        sunriseLabel.text = currentWeatherModel.sunrise
        sunsetLabel.text = currentWeatherModel.sunset
    }
}
