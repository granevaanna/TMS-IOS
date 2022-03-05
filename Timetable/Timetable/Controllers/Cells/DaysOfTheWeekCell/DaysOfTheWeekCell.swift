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
    
    func setupWith(day: String){
        dayLabel.text = day
    }
    
    func setMainColorForDayLabel(){
        backgroundColor = .mainColor
        dayLabel.textColor = .white
    }
    func setBlackColorForDayLabel(){
        backgroundColor = .white
        dayLabel.textColor = .black
    }
}
