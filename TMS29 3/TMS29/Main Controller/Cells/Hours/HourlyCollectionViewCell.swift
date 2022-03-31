//
//  HourlyCollectionViewCell.swift
//  TMS29
//
//  Created by lion on 15.01.22.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var comingTimeLabel: UILabel!
    @IBOutlet weak var hoursWeatherImage: UIImageView!
    @IBOutlet weak var hoursTempLabel: UILabel!
    
    static let identifier = "HourlyCollectionViewCell"
    
    func setupWith(upcomingHoursWeather: WeatherModel) {
        comingTimeLabel.text = upcomingHoursWeather.time
        hoursWeatherImage.image = UIImage(systemName: upcomingHoursWeather.systemIconNameString)
        hoursTempLabel.text = upcomingHoursWeather.temperature
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
