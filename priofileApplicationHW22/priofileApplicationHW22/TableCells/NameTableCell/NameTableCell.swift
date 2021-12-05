//
//  NameTableCell.swift
//  priofileApplicationHW22
//
//  Created by Анна Гранёва on 5.12.21.
//

import UIKit

final class NameTableCell: UITableViewCell {
    
    static let identifier = "kNameTableCell"
    @IBOutlet private weak var nameLabel: UILabel!
    
    func setupWith(){
        if let nameString = defaults.string(forKey: NameTableCell.identifier){
        nameLabel.text =  "\(nameString)"
        } else {
            nameLabel.text = "Имя"
        }
    }
    
    @IBAction func editAction(_ sender: Any) {
        EditViewController.controllerType = .name
        NotificationCenter.default.post(name: .openEditViewController, object: nil)
    }
}
