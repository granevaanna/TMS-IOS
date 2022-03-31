//
//  DaysCell.swift
//  weatherForLocation
//
//  Created by Анна Гранёва on 31.03.22.
//

import UIKit

class DaysCell: UITableViewCell {
    static let identifier = "kDaysCell"
    @IBOutlet private weak var tableView: UITableView!
    private var dataSource: [DailyWeatherModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "DayCell", bundle: nil), forCellReuseIdentifier: DayCell.identifier)
    }
    
    func setup(dailyWeather: [DailyWeatherModel]){
        dataSource = dailyWeather
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension DaysCell: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DayCell.identifier, for: indexPath) as! DayCell
        cell.isUserInteractionEnabled = false
        cell.setupDailyWeather(dailyWeatherModel: dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
}
