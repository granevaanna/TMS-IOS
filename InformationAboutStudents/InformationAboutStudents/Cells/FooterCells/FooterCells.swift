//
//  FooterCells.swift
//  InformationAboutStudents
//
//  Created by Анна Гранёва on 28.10.21.
//

import UIKit

class FooterCells: UITableViewCell {

    @IBOutlet weak var numberOfStudents: UILabel!
    @IBOutlet weak var averageMark: UILabel!
    
    static let identifier = "kFooterCells"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(displayP3Red: 0.88, green: 0.67, blue: 0.63, alpha: 1)
    }
    
    func setupCellWith(model: [StudentModel]){
        let averageMarkValue = Double(model.compactMap({$0.markString}).reduce(0, +)) / Double(model.count)
        numberOfStudents.text = "\(model.count)"
        averageMark.text = "\(round(100 * averageMarkValue)/100)"

    }
    
}
