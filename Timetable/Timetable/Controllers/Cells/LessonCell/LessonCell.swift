//
//  LessonCell.swift
//  Timetable
//
//  Created by Анна Гранёва on 16.02.22.
//

import UIKit

final class LessonCell: UITableViewCell {
    static let identifier = "kLessonCell"
    
    @IBOutlet private weak var lessonNameLabel: UILabel!
    @IBOutlet private weak var teacherLabel: UILabel!
    @IBOutlet private weak var audienceLabel: UILabel!
    @IBOutlet private weak var startTimeLabel: UILabel!
    @IBOutlet private weak var endTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.mainColor.cgColor
        self.backgroundColor = UIColor(named: "backgroundColor")
    }
    
    func setupWith(lesson: LessonModel){
        lessonNameLabel.text = lesson.lessonName
        teacherLabel.text = lesson.teacher
        audienceLabel.text = lesson.audience
        startTimeLabel.text = lesson.startTime
        endTimeLabel.text = lesson.endTime
    }
}
