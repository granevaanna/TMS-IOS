//
//  HomeWorkModel.swift
//  Timetable
//
//  Created by Анна Гранёва on 11.04.22.
//

import UIKit

struct HomeWorkModel: Codable, Equatable{
    var lessonName: String
    var homeWork: String
    var deadline: Date
    var isDone: Bool
    var isActive: Bool
    
    init(deadline: Date, lessonName: String, homeWork: String){
        self.lessonName = lessonName
        self.homeWork = homeWork
        self.deadline = deadline
        self.isDone = false
        self.isActive = true
    }
    
    var deadlineString: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd.MM.YYYY"
        return formatter.string(from: deadline)
    }
    
    static func convertStringToDate(deadlineString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd.MM.YYYY"
        let dateFormatter = formatter
        return dateFormatter.date(from: deadlineString)
    }
    
    static func convertDateToString(deadline: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd.MM.YYYY"
        return formatter.string(from: deadline)
    }
}
