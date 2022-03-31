//
//  ViewController.swift
//  TMS29
//
//  Created by Aleksei Elin on 10.01.22.
//

import UIKit
import CoreLocation
import MapKit
import Contacts

final class MainViewController: UIViewController {
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    
    private let locationManager = CLLocationManager()
    
    private var isLoaded = false
    private var dataSource: [CellType] = []
    private enum CellType {
        case current(day: WeatherModel)
        case hourly(hours: [WeatherModel])
        case upcoming(days: [WeatherModel])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupTableView()
           
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        }
    }
    
    private func loadData(lat: Double, lon: Double, cityName: String) {
        APIManager.getOneCallWeather(lat: lat, lon: lon) { [weak self] response in
            guard let self = self else { return }
            
            let logicBlock: (WeatherFullModel) -> Void = { response in
                response.currentDay.location = cityName
                
                self.dataSource.append(.current(day: response.currentDay))
                self.dataSource.append(.hourly(hours: response.hourly))
                self.dataSource.append(.upcoming(days: response.upcomingDays))
                self.updateImageBackground(model: response.currentDay)
                self.tableView.reloadData()
            }
            
            if let response = response {
                let jsonEncoder = JSONEncoder()
                do {
                    let encodedData = try jsonEncoder.encode(response)
                    UserDefaults.standard.set(encodedData, forKey: "kWeather")
                    print("User data file writed")
                    
                } catch {
                    print("Couldn't write user data file")
                }
                
                logicBlock(response)
                
            } else if let data = UserDefaults.standard.value(forKey: "kWeather") as? Data,
                      let response = try? JSONDecoder().decode(WeatherFullModel.self, from: data) {
                logicBlock(response)
            }
            
        }
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: CurrentDayWeatherCell.identifier, bundle: nil),
                           forCellReuseIdentifier:  CurrentDayWeatherCell.identifier)
        tableView.register(UINib(nibName: DaysWeatherCell.identifier, bundle: nil),
                           forCellReuseIdentifier:  DaysWeatherCell.identifier)
        tableView.register(UINib(nibName: HourlyViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: HourlyViewCell.identifier)
    }
    
    private func updateImageBackground(model: WeatherModel){
        DispatchQueue.main.async {
            self.backgroundImageView.image = UIImage(systemName: model.systemIconNameString)
        }
    }
}


//MARK: - UITableViewDataSource, UITableViewDelegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath.row] {
        case .hourly(hours: _):
            return CGFloat(150.0)
            
        default:
            return UITableView.automaticDimension
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {
            
        case .current(day: let day):
            let cell = tableView.dequeueReusableCell(withIdentifier: CurrentDayWeatherCell.identifier,
                                                     for: indexPath) as! CurrentDayWeatherCell
            cell.setupWith(currentWeatherModel: day)
            return cell
            
        case .hourly(hours: let hours):
            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyViewCell.identifier,
                                                     for: indexPath) as! HourlyViewCell
            cell.setupWith(upcomingHoursWeatherModel: hours)
            return cell
            
        case .upcoming(days: let days):
            let cell = tableView.dequeueReusableCell(withIdentifier: DaysWeatherCell.identifier,
                                                     for: indexPath) as! DaysWeatherCell
            cell.setupWith(upcomingWeatherModel: days)
            cell.delegate = self
            return cell
            
        }
        
    }
    
}

//MARK: - CLLocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        location.placemark { [weak self] placemark, error in
            guard let placemark = placemark, self?.isLoaded == false else { return }
            self?.isLoaded = true
            
            self?.loadData(lat: locValue.latitude,
                           lon: locValue.longitude,
                           cityName: placemark.city ?? "Minsk")
        }
        
    }
}


//MARK: - DaysWeatherCellDelegate
extension MainViewController: DaysWeatherCellDelegate {
    func reloadParentTable() {
        tableView.reloadData()
    }
}




extension CLPlacemark {
    /// street name, eg. Infinite Loop
    var streetName: String? { thoroughfare }
    /// // eg. 1
    var streetNumber: String? { subThoroughfare }
    /// city, eg. Cupertino
    var city: String? { locality }
    /// neighborhood, common name, eg. Mission District
    var neighborhood: String? { subLocality }
    /// state, eg. CA
    var state: String? { administrativeArea }
    /// county, eg. Santa Clara
    var county: String? { subAdministrativeArea }
    /// zip code, eg. 95014
    var zipCode: String? { postalCode }
    /// postal address formatted
    @available(iOS 11.0, *)
    var postalAddressFormatted: String? {
        guard let postalAddress = postalAddress else { return nil }
        return CNPostalAddressFormatter().string(from: postalAddress)
    }
}

extension CLLocation {
    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
    }
}
