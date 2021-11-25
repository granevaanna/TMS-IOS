//
//  UserModel.swift
//  lesson_19
//
//  Created by Анна Гранёва on 22.11.21.
//

import UIKit

final class UserModel{
    
    static let shared = UserModel()
    
    var profileImage: UIImage?
    var profileName: String = ""
    var profileEmail: String?
    
    var locationString: String?
    var birthdayString: String?
    var personalInfo: String?
    
    private init(){}
}

class AdditionalInfoModel{
    let sectionName: String
    var sectionValue: String?
    let modelType: AdditionalInfoModelType
    
    init(sectionName: String, sectionValue: String?, modelType: AdditionalInfoModelType){
        self.sectionName = sectionName
        self.sectionValue = sectionValue
        self.modelType = modelType
    }
}

enum AdditionalInfoModelType{
    case data
    case address
    case description
}
