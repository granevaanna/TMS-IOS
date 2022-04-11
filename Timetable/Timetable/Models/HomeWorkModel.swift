//
//  HomeWorkModel.swift
//  Timetable
//
//  Created by Анна Гранёва on 11.04.22.
//

import UIKit

struct HomeWorkModel{
    var lessonName: String
    var homeWork: String
    var deadline: Date
    var isDone: Bool
    
    init(lessonName: String, homeWork: String, deadline: Date, isDone: Bool){
        self.lessonName = lessonName
        self.homeWork = homeWork
        self.deadline = deadline
        self.isDone = isDone
    }
}
