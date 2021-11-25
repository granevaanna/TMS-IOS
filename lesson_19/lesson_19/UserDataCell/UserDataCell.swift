//
//  UserDataCell.swift
//  lesson_19
//
//  Created by Анна Гранёва on 22.11.21.
//

import UIKit

final class UserDataCell: UITableViewCell {
    static let identifier = "kUserDataCell"
    
    @IBOutlet private weak var photoImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var gmailLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImage.layer.cornerRadius = photoImage.frame.width / 2
    }
    
    func setupCellData(){
        photoImage.image = UserModel.shared.profileImage
        nameLabel.text = UserModel.shared.profileName
        gmailLabel.text = UserModel.shared.profileEmail
    }
}
