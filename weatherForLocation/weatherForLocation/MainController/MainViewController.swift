//
//  ViewController.swift
//  weatherForLocation
//
//  Created by Анна Гранёва on 18.01.22.
//

import UIKit
import CoreLocation

final class MainViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    var dataSourse: [CellType] = []
    enum CellType{
        case current(currentWeather: CurrentWeatherModel)
        case daily(dailyWeather: [DailyWeatherModel])
    }
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        return locationManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSettingsForTable()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.requestLocation()
        }
    }
    
    private func setSettingsForTable(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CurrentWeatherCell", bundle: nil), forCellReuseIdentifier: CurrentWeatherCell.identifier)
        tableView.register(UINib(nibName: "DaysCell", bundle: nil), forCellReuseIdentifier: DaysCell.identifier)
        tableView.backgroundColor = UIColor.clear
    }
    
    func loadData(lat: Double, lon: Double){
        APIManager.getOneCallWeather(lat: lat, lon: lon) { [weak self] fullWeather in
            guard let self = self else { return }
            if let current = fullWeather?.current,
               let daily = fullWeather?.days{
                self.dataSourse.append(.current(currentWeather: current))
                self.dataSourse.append(.daily(dailyWeather: daily))
            }
            self.tableView.reloadData()
        }
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSourse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSourse[indexPath.row] {
        case .current(currentWeather: let currentWeather):
            let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherCell.identifier, for: indexPath) as! CurrentWeatherCell
            cell.isUserInteractionEnabled = false
            cell.setupCurrentWeather(currentWeatherModel: currentWeather)
            return cell
        case .daily(dailyWeather: let days):
            let cell = tableView.dequeueReusableCell(withIdentifier: DaysCell.identifier, for: indexPath) as! DaysCell
            cell.setup(dailyWeather: days)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSourse[indexPath.row]{
        case .current(currentWeather: let current):
            return 250
        case .daily(dailyWeather: let dailyWeather):
            return 942
        }
    }
}

//MARK: - CLLocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location?.coordinate else { return }
        let latitude = location.latitude
        let longitude = location.longitude
        loadData(lat: latitude, lon: longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
