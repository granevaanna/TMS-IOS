//
//  DayOfTheWeekModel.swift
//  Timetable
//
//  Created by Анна Гранёва on 10.03.22.
//

import UIKit

struct DayOfTheWeekModel{
    let dayName: String
    var isSelect: Bool
    
    init(dayName: String){
        self.dayName = dayName
        self.isSelect = false
    }
}
