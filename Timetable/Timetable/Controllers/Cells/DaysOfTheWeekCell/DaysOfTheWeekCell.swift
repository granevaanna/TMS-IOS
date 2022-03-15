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
            setSelectedColor()
        } else {
            setStandartColor()
        }
    }
    
    private func setSelectedColor(){
        backgroundColor = .mainColor
        dayLabel.textColor = .white
    }
    private func setStandartColor(){
        backgroundColor = .clear
        dayLabel.textColor = UIColor(named: "labelTextColor")
    }
}
