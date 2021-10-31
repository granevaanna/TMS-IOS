//
//  HeaderCell.swift
//  InformationAboutStudents
//
//  Created by Анна Гранёва on 29.10.21.
//

import UIKit

final class HeaderCell: UITableViewCell {

    static let identifier = "kHeaderCell"
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headerLabel.backgroundColor = UIColor(displayP3Red: 0.88, green: 0.67, blue: 0.63, alpha: 1)
        headerLabel.textColor = .white
        headerLabel.font = .systemFont(ofSize: 30)
    }
}
