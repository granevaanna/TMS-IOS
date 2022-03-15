//
//  DaysOfTheWeekCell.swift
//  Timetable
//
//  Created by Анна Гранёва on 16.02.22.
//

import UIKit

final class DaysOfTheWeekCell: UICollectionViewCell {
    static let identifier = "kDaysOfTheWeekCell"
    @IBOutlet weak var dayLabel: UILabel!
    
    func setupWith(day: DayOfTheWeekModel){
        dayLabel.text = day.dayName
        
        if day.isSelect{
            setMainColorForDayLabel()
        } else {
            setBlackColorForDayLabel()
        }
    }
    
    func setMainColorForDayLabel(){
        backgroundColor = .mainColor
        dayLabel.textColor = .white
    }
    func setBlackColorForDayLabel(){
        backgroundColor = .clear
//        dayLabel.textColor = .black
        dayLabel.textColor = UIColor(named: "labelTextColor")
    }
}
