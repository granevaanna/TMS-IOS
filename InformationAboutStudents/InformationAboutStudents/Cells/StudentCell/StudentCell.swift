//
//  StudentCell.swift
//  InformationAboutStudents
//
//  Created by Анна Гранёва on 28.10.21.
//

import UIKit

struct StudentModel{
    let nameString:String
    let markString:Double
    let groupString:Int
}

final class StudentCell: UITableViewCell {

    static let identifier = "kStudentCell"
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var markLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(displayP3Red: 0.82, green: 0.82, blue: 0.82, alpha: 1)
    }

    func setupCellWith(model: StudentModel){
        nameLabel.text = model.nameString
        markLabel.text = "\(model.markString)"
    }
}
