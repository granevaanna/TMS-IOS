//
//  LessonModel.swift
//  Timetable
//
//  Created by Анна Гранёва on 18.02.22.
//

import UIKit

struct LessonModel: Codable, Equatable{
    var lessonName: String
    var teacher: String
    var audience: String
    var startTime: String
    var endTime: String
    var lessonType: String
    
    init(){
        self.lessonName = ""
        self.teacher = ""
        self.audience = ""
        self.startTime = ""
        self.endTime = ""
        self.lessonType = ""
    }
    
    init(lessonName: String, teacher: String, audience: String, startTime: String, endTime: String, lessonType: String){
        self.lessonName = lessonName
        self.teacher = teacher
        self.audience = audience
        self.startTime = startTime
        self.endTime = endTime
        self.lessonType = lessonType
    }
}
