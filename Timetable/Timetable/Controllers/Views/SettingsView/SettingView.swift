//
//  SettingView.swift
//  Timetable
//
//  Created by Анна Гранёва on 3.03.22.
//

import UIKit

protocol SettingViewDelegate: AnyObject{
    func showDeleteAllAllert()
}

final class SettingView: UIView{
    @IBOutlet private var contentView: UIView!
    weak var delegate: SettingViewDelegate?

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
            contentView.layer.cornerRadius = 10
        }
    
    @IBAction private func editButtonAction(_ sender: Any) {
    }
    
    @IBAction private func deleteAllButtonAction(_ sender: Any) {
        delegate?.showDeleteAllAllert()
    }
    
}
