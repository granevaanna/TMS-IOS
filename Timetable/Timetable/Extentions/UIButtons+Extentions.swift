//
//  UIButtons+Extentions.swift
//  Timetable
//
//  Created by Анна Гранёва on 11.03.22.
//

import UIKit

extension UIButton{
    func mainButton(){
        backgroundColor = UIColor.mainColor
        titleLabel?.textColor = .white
        layer.cornerRadius = 10
    }
}
