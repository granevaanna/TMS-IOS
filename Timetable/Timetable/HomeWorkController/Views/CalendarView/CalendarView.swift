//
//  CalendarView.swift
//  Timetable
//
//  Created by Анна Гранёва on 28.04.22.
//

import UIKit
import FSCalendar

protocol CalendarViewDelegate: AnyObject{
    func hideCalendarView()
    func saveSelectedDate(date: Date)
}

final class CalendarView: UIView{
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var calendar: FSCalendar!
    
    private var selectedDate: Date?
    weak var delegate: CalendarViewDelegate?
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }
        
        private func commonInit() {
            Bundle.main.loadNibNamed("\(type(of: self))", owner: self, options: nil)
            addSubview(contentView)
            contentView.frame = bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            contentView.layer.cornerRadius = 20
            calendar.layer.cornerRadius = 20
            calendar.delegate = self
        }
    
    @IBAction private func okButtonAction(_ sender: Any) {
        guard let selectedDate = selectedDate else { return }
        delegate?.saveSelectedDate(date: selectedDate)
        delegate?.hideCalendarView()
        
    }
    @IBAction private func cancelButtonAction(_ sender: Any) {
        delegate?.hideCalendarView()
    }
    
    
}

//MARK: - FSCalendarDelegate
extension CalendarView: FSCalendarDelegate{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
    }
}