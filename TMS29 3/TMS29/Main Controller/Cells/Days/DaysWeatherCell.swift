//
//  DaysWeatherCell.swift
//  TMS29
//
//  Created by Aleksei Elin on 13.01.22.
//

import UIKit


protocol DaysWeatherCellDelegate: AnyObject {
    func reloadParentTable()
}

final class DaysWeatherCell: UITableViewCell {
    static let identifier = "DaysWeatherCell"
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableViewHeight: NSLayoutConstraint!
    
    weak var delegate: DaysWeatherCellDelegate?
    
    private var dataSource: [WeatherModel] = []
    private var cellHeights = [IndexPath: CGFloat]() {
        didSet {
            tableViewHeight.constant = cellHeights.values.reduce(0, +)
            
            delegate?.reloadParentTable()
        }
    }
    
    override func awakeFromNib() {
        setupTableView()
    }
    
    func setupWith(upcomingWeatherModel: [WeatherModel]){
        self.dataSource = upcomingWeatherModel
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: DayViewCell.identifier, bundle: nil), forCellReuseIdentifier: DayViewCell.identifier)
        tableView.separatorInset.left = 10
        tableView.separatorInset.right = 10
        tableView.layer.cornerRadius = 10
        //tableView.rowHeight = UITableView.automaticDimension
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension DaysWeatherCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath] ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DayViewCell.identifier, for: indexPath) as! DayViewCell
        
        cell.setupWith(upcomingDaysWeather: dataSource[indexPath.row])
        
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
}
