//
//  TableViewCellWithTablel.swift
//  lesson_19
//
//  Created by Анна Гранёва on 22.11.21.
//

import UIKit

protocol TableViewCellWithTablelDelegate: AnyObject{
    func birtdayAction(model: AdditionalInfoModel)
}

final class TableViewCellWithTablel: UITableViewCell {
    static let identifier = "kTableViewCellWithTablel"
    weak var delegate: TableViewCellWithTablelDelegate?
    private var dataSource: [AdditionalInfoModel] = []

    @IBOutlet private weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 10
        
        tableView.register(UINib(nibName: "InformationTableViewCell", bundle: nil), forCellReuseIdentifier: InformationTableViewCell.identifier)
    }
    
    func setupWith(data: [AdditionalInfoModel]){
        dataSource = data
        tableView.reloadData()
    }
}


//MARK: - UITableViewDataSource, UITableViewDelegate
extension TableViewCellWithTablel: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell.identifier, for: indexPath) as! InformationTableViewCell
        cell.setupWith(model: dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            delegate?.birtdayAction(model: dataSource[indexPath.row])
    }
}

