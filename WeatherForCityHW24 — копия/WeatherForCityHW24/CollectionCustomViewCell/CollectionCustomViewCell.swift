//
//  CollectionCustomViewCell.swift
//  WeatherForCityHW24
//
//  Created by Анна Гранёва on 12.12.21.
//

import UIKit

class CollectionCustomViewCell: UICollectionViewCell {
    static let identifier = "kCollectionCustomViewCell"
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var dataLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var descriptionWeatherLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func getWeatherFor(city: String) {
        dataLabel.alpha = 0
        activityIndicator.startAnimating()
        APIRequests.getWeatherWith(city: city) { [weak self] weather, error  in
            self?.activityIndicator.stopAnimating()
            if !city.isEmpty{
                self?.activityIndicator.isHidden = true
                self?.tempLabel.text = "\(weather?.main?.temp ?? 0) C"
                self?.tempLabel.alpha = 1
                
                self?.descriptionWeatherLabel.text = weather?.weather?.first?.description
                self?.descriptionWeatherLabel.alpha = 1
            } else{
                self?.tempLabel.alpha = 0
                self?.descriptionWeatherLabel.alpha = 0
            }
        }
    }
        
    func getDailyWeatherFor(city: String, index: Int) {
            activityIndicator.startAnimating()
            APIRequests.getDailyWeatherWith(city: city) { [weak self] weather, error  in
                self?.activityIndicator.stopAnimating()
                if !city.isEmpty{
                    self?.activityIndicator.isHidden = true
                    
                    self?.tempLabel.text = "\(weather?.list?[index].main?.temp ?? 0) C"
                    self?.tempLabel.alpha = 1
                    self?.descriptionWeatherLabel.text = weather?.list?[index].weather?.first?.description
                    self?.descriptionWeatherLabel.alpha = 1
                    self?.dataLabel.text = weather?.list?[index].dt_txt
                    self?.dataLabel.alpha = 1
                }else{
                    self?.tempLabel.alpha = 0
                    self?.descriptionWeatherLabel.alpha = 0
                }
            }
        }
}
