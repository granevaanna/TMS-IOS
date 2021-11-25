//
//  InformationTableViewCell.swift
//  lesson_19
//
//  Created by Анна Гранёва on 22.11.21.
//

import UIKit

class InformationTableViewCell: UITableViewCell {
    static let identifier = "kInformationTableViewCell"
    
    @IBOutlet private weak var sectionNameLabel: UILabel!
    @IBOutlet weak var sectionValueLabel: UILabel!
    @IBOutlet private weak var arrowImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupWith(model: AdditionalInfoModel){
        sectionNameLabel.text = model.sectionName
        sectionValueLabel.text = model.sectionValue
//        let sectionValue = UserModel.shared.birthdayString ?? ""
//        sectionValueLabel.text = sectionValue
    }
}

