//
//  Model.swift
//  priofileApplicationHW22
//
//  Created by Анна Гранёва on 6.12.21.
//

import UIKit

let defaults = UserDefaults.standard

enum EditViewControllerType{
    case name
    case dateOfBirth
    case photo
}

struct UserModel{
    var nameString: String
    var dateOfBirthString: String
    var photoImage: UIImage
}
