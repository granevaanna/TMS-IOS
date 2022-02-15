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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupWith(day: String){
        dayLabel.text = day
    }
    
    func setMainColorForDayLabel(){
        dayLabel.textColor = .mainColor
    }
}
