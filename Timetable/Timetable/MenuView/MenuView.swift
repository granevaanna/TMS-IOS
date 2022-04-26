//
//  SettingView.swift
//  Timetable
//
//  Created by Анна Гранёва on 13.04.22.
//

import UIKit

protocol MenuViewDelegate: AnyObject{
    func presentTimetableVC()
    func presentHomeWorkVC()
}


class MenuView: UIView{
    @IBOutlet private var contentView: UIView!
    
    weak var delegate: MenuViewDelegate?

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
        }
    
    @IBAction private func timetableOfLessonsButtonAction(_ sender: Any) {
        delegate?.presentTimetableVC()
    }
    
    @IBAction private func homeWorkButtonAction(_ sender: Any) {
        delegate?.presentHomeWorkVC()
    }
}
