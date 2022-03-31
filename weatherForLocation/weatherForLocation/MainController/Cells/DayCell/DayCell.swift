//
//  DayCell.swift
//  weatherForLocation
//
//  Created by Анна Гранёва on 18.01.22.
//

import UIKit

class DayCell: UITableViewCell {
    static let identifier = "kDayCell"
    
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var weatherImageIcon: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var weatherDescription: UILabel!
    @IBOutlet private weak var sunrizeTimeLabel: UILabel!
    @IBOutlet private weak var sunsetTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .mainColor
    }
    
    func setupDailyWeather(dailyWeatherModel: DailyWeatherModel){
        DispatchQueue.main.async {
            self.dayLabel.text = dailyWeatherModel.dayString
            self.weatherImageIcon.image = UIImage(systemName: dailyWeatherModel.systemIconNameString)
            self.temperatureLabel.text = dailyWeatherModel.temperatureString
            self.weatherDescription.text = dailyWeatherModel.weatherDescription
            self.sunrizeTimeLabel.text = dailyWeatherModel.sunrizeTimeString
            self.sunsetTimeLabel.text = dailyWeatherModel.sunsetTimeString
        }
    }
}
