//
//  StudentCell.swift
//  InformationAboutStudents
//
//  Created by Анна Гранёва on 28.10.21.
//

import UIKit

struct StudentModel{
    let nameString:String
    let markString:Int
    let groupString:Int
}

final class StudentCell: UITableViewCell {

    static let identifier = "kStudentCell"
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var markLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(displayP3Red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    }

    func setupCellWith(model: StudentModel){
        nameLabel.text = model.nameString
        markLabel.text = "\(model.markString)"
    }
    

    
}
