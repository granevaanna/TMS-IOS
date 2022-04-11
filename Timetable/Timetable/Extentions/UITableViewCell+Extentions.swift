//
//  UITableViewCell+Extentions.swift
//  Timetable
//
//  Created by Анна Гранёва on 11.04.22.
//

import UIKit

extension UITableViewCell{
    func setupMainAppearance(){
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.mainColor.cgColor
//        self.backgroundColor = UIColor(named: "backgroundColor")
    }
}
