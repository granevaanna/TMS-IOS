//
//  FooterCells.swift
//  InformationAboutStudents
//
//  Created by Анна Гранёва on 28.10.21.
//

import UIKit

final class FooterCells: UITableViewCell {

    @IBOutlet private weak var numberOfStudents: UILabel!
    @IBOutlet private weak var averageMark: UILabel!
    
    static let identifier = "kFooterCells"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(displayP3Red: 0.66, green: 0.66, blue: 0.66, alpha: 1)
    }
    
    func setupCellWith(model: [StudentModel]){
        let averageMarkValue = Double(model.compactMap({$0.markString}).reduce(0, +)) / Double(model.count)
        numberOfStudents.text = "\(model.count)"
        averageMark.text = "\(round(100 * averageMarkValue)/100)"
    }
}
