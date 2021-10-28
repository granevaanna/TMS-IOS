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
    @IBOutlet private weak var groupLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCellWith(model: StudentModel){
        nameLabel.text = model.nameString
        markLabel.text = "\(model.markString)"
        groupLabel.text = "\(model.groupString)"
    }
    

    
}
