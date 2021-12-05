//
//  DateOfBirthTableCell.swift
//  priofileApplicationHW22
//
//  Created by Анна Гранёва on 6.12.21.
//

import UIKit

final class DateOfBirthTableCell: UITableViewCell {
    static let identifier = "kDateOfBirthTableCell"
    @IBOutlet private weak var dateOfBirthLabel: UILabel!
    
    func setupWith(){
        if let birthdayString = defaults.string(forKey: DateOfBirthTableCell.identifier){
        dateOfBirthLabel.text =  "Дата Рождения: \(birthdayString)"
        } else {
            dateOfBirthLabel.text = "Дата Рождения"
        }
    }
    
    @IBAction func editAction(_ sender: Any) {
        EditViewController.controllerType = .dateOfBirth
        NotificationCenter.default.post(name: .openEditViewController, object: nil)
    }
}
