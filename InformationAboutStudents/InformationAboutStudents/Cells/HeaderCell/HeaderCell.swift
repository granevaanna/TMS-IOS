//
//  HeaderCell.swift
//  InformationAboutStudents
//
//  Created by Анна Гранёва on 29.10.21.
//

import UIKit

class HeaderCell: UITableViewCell {

    static let identifier = "kHeaderCell"
    @IBOutlet  weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headerLabel.backgroundColor = UIColor(displayP3Red: 0.89, green: 0.59, blue: 0.54, alpha: 1)
    }

    
}
