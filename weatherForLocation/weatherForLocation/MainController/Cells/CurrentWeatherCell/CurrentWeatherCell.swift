//
//  CurrentWeatherCell.swift
//  weatherForLocation
//
//  Created by Анна Гранёва on 18.01.22.
//

import UIKit

final class CurrentWeatherCell: UITableViewCell {
    static let identifier = "kCurrentWeatherCell"
    
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var weatherImageIcon: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var weatherDescription: UILabel!
    @IBOutlet private weak var sunrizeTimeLabel: UILabel!
    @IBOutlet private weak var sunsetTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.clear
    }
    
    func setupCurrentWeather(currentWeatherModel: CurrentWeatherModel){
        DispatchQueue.main.async {
            self.cityNameLabel.text = currentWeatherModel.cityName
            self.weatherImageIcon.image = UIImage(systemName: currentWeatherModel.systemIconNameString)
            self.temperatureLabel.text = currentWeatherModel.temperatureString
            self.weatherDescription.text = currentWeatherModel.weatherDescription
            self.sunrizeTimeLabel.text = currentWeatherModel.sunrizeTimeString
            self.sunsetTimeLabel.text = currentWeatherModel.sunsetTimeString
        }
    }
}
