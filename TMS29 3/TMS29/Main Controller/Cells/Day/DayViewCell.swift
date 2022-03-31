//
//  DayViewCell.swift
//  TMS29
//
//  Created by lion on 14.01.22.
//

import UIKit
//protocol DayViewCellDelegate: AnyObject {
//    func setupWith(upcomingWeatherModel: WeatherModel)
//}

class DayViewCell: UITableViewCell {
    
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var sunriceLabel: UILabel!
    @IBOutlet private weak var sunsetLabel: UILabel!
    
   // weak var delegate: DayViewCellDelegate?
    
    static let identifier = "DayViewCell"
    
    
   func setupWith(upcomingDaysWeather: WeatherModel){
        dayLabel.text = upcomingDaysWeather.currentDayString
        tempLabel.text = upcomingDaysWeather.minAndMaxTemp
        sunriceLabel.text = upcomingDaysWeather.sunrise
        sunsetLabel.text = upcomingDaysWeather.sunset
    }
    
}




//override func awakeFromNib() {
//    super.awakeFromNib()
//    // Initialization code
//}
//
//override func setSelected(_ selected: Bool, animated: Bool) {
//    super.setSelected(selected, animated: animated)
//
//    // Configure the view for the selected state
//}
