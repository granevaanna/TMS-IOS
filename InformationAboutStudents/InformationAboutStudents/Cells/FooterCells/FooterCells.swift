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
        // Initialization code
    }
    
    func setupCellWith(model: [StudentModel]){
        let averageMarkValue = model.compactMap({$0.markString}).reduce(0, +) / model.count
        numberOfStudents.text = "\(model.count)"
        averageMark.text = "\(averageMarkValue)"

    }
    
}
